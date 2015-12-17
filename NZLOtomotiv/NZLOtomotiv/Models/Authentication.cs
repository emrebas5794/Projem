using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using NZLOtomotiv.Models;
using System.Data.SqlClient;
using System.Diagnostics;

namespace NZLOtomotiv.Models
{
    internal class Authentication
    {
        internal static string Login(string Username, string Password)
        {
            if (HttpContext.Current.Session["LoginAttempts"] == null)
                HttpContext.Current.Session["LoginAttempts"] = 0;
            if ((int)HttpContext.Current.Session["LoginAttempts"] > 5)
            {
                return "Çok fazla hatalı deneme. Hesap kilitlendi.";
            }
            HttpContext.Current.Session["LoginAttempts"] = (int)HttpContext.Current.Session["LoginAttempts"] + 1;
            //Open connection and get password hash
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand("SELECT password_hash FROM Kullanicilar WHERE username = @user OR email = @user", connection);
            command.Parameters.AddWithValue("user", Username);
            SqlDataReader reader = command.ExecuteReader();
            if (!reader.HasRows)
                return "Kullanıcı Adı / Eposta sistemde kayıtlı bulunamadı.";
            reader.Read();
            string HashedPassword = (string)reader[0];
            connection.Close();
            reader.Close();

            //Check if password is right
            if (!HashPass.CheckPasswordHash(Password, HashedPassword))
                return "Şifre Hatalı";

            //Set session cookies
            RegisterUserToSession(Username);
            Globals.LoggedInUsers.Add(Username);

            return "OK";
        }

        private static void RegisterUserToSession(string Username)
        {
            HttpContext.Current.Session.Add("Username", Username);
            HttpContext.Current.Session.Add("IP", HttpContext.Current.Request.ServerVariables["remote_addr"]);
            HttpContext.Current.Session.Add("Agent", HttpContext.Current.Request.ServerVariables["http_user_agent"]);
            HttpContext.Current.Session.Add("LastActivity", DateTime.Now);
        }

        internal static bool Register(string Username, string Password, string Email, string Phone = null)
        {
            string PasswordHash = HashPass.HashPassword(Password);

            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand("RegisterUser", connection);
            command.Parameters.AddWithValue("username", Username);
            command.Parameters.AddWithValue("password", PasswordHash);
            command.Parameters.AddWithValue("email", Email);
            command.Parameters.AddWithValue("phone", Phone);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            try
            {
                command.ExecuteNonQuery();
            }
            catch (SqlException e)
            {
                int ecode = e.Number;
                switch (ecode)
                {
                    default:
                        return false;
                    case 2607:
                        return false;
                }
            }
            connection.Close();
            return true;
        }
    }
}