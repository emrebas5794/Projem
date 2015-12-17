using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Cryptography;

namespace NZLOtomotiv.Models
{
    public class HashPass
    {
        private const int HashSize = 32;
        private const int SaltSize = 32;
        private const int SlowIterationCount = 1000;

        public static string HashPassword(string Password)
        {
            //Create secure random salt
            RNGCryptoServiceProvider csp = new RNGCryptoServiceProvider();
            byte[] salt = new byte[SaltSize];
            csp.GetBytes(salt);

            byte[] hash = HashString(Password, salt);

            return SlowIterationCount + ":" + Convert.ToBase64String(salt) + ":" + Convert.ToBase64String(hash);
        }
        public static string HashPassword(string Password, int hashSize, int saltSize, int PBKDF2Iteration)
        {
            //Create secure random salt
            RNGCryptoServiceProvider csp = new RNGCryptoServiceProvider();
            byte[] salt = new byte[saltSize];
            csp.GetBytes(salt);

            byte[] hash = HashString(Password, salt, PBKDF2Iteration, hashSize);

            return PBKDF2Iteration + ":" + Convert.ToBase64String(salt) + ":" + Convert.ToBase64String(hash);
        }

        public static bool CheckPasswordHash(string Password, string HashedPassword)
        {
            string[] _hashdetails = HashedPassword.Split(':');
            int IterationCount = int.Parse(_hashdetails[0]);
            byte[] Salt = Convert.FromBase64String(_hashdetails[1]);
            byte[] Hash = Convert.FromBase64String(_hashdetails[2]);

            byte[] _hash = HashString(Password, Salt, IterationCount, Hash.Length);

            uint diff = (uint)Hash.Length ^ (uint)_hash.Length;
            for (int i = 0; i < Hash.Length && i < _hash.Length; i++)
                diff |= (uint)(Hash[i] ^ _hash[i]);

            return diff == 0;
        }

        private static byte[] HashString(string Password, byte[] salt)
        {
            Rfc2898DeriveBytes pbkdf2 = new Rfc2898DeriveBytes(Password, salt);
            pbkdf2.IterationCount = SlowIterationCount;
            return pbkdf2.GetBytes(HashSize);
        }
        private static byte[] HashString(string Password, byte[] salt, int IterationCount, int hashSize)
        {
            Rfc2898DeriveBytes pbkdf2 = new Rfc2898DeriveBytes(Password, salt);
            pbkdf2.IterationCount = IterationCount;
            return pbkdf2.GetBytes(hashSize);
        }
    }
}