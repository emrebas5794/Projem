using MVC_SimpleBlog.DAL;
using MVC_SimpleBlog.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MVC_SimpleBlog.BLL
{
    public class UserRepository : IRepository<UserDTO>
    {
        DbEntities dbContext;

        public int Insert(UserDTO item)
        {
            int result = 0;
            using (dbContext = new DbEntities())
            {
                User user = new User();
                user.UserName = item.UserName;
                user.NickName = item.NickName;
                user.Password = item.Password;
                dbContext.Users.Add(user);
                try
                {
                    result = dbContext.SaveChanges();
                }
                catch (Exception)
                {

                    return -1;
                }
            }
            return result;
        }

        public int Delete(UserDTO item)
        {
            int result = 0;
            User user = null;
            using (dbContext = new DbEntities())
            {
                user = (from u in dbContext.Users
                        where u.Id == item.Id
                        select u).SingleOrDefault();
                dbContext.Users.Remove(user);

                try
                {
                    result = dbContext.SaveChanges();
                }
                catch (Exception)
                {

                    return -1;
                }
            }
            return result;
        }

        public int Update(UserDTO item)
        {
            User user = null;
            int result = 0;
            using (dbContext = new DbEntities())
            {
                user = (from u in dbContext.Users
                        where u.Id == item.Id
                        select u
                        ).SingleOrDefault();
                user.NickName = item.NickName;
                user.Password = item.Password;
                user.UserName = item.UserName;
                try
                {
                    result = dbContext.SaveChanges();
                }
                catch (Exception)
                {

                    return -1;
                }
            }
            return result;
        }

        public List<UserDTO> GetAll()
        {
            List<UserDTO> userList = null;
            using (dbContext = new DbEntities())
            {
                userList = (from u in dbContext.Users
                            select new UserDTO
                            {
                                Id = u.Id,
                                UserName = u.UserName,
                                NickName = u.NickName,
                                Password = u.Password
                            }).ToList();
            }
            return userList;
        }

        public UserDTO GetById(int id)
        {
            UserDTO user = null;
            using (dbContext = new DbEntities())
            {
                user = (from u in dbContext.Users
                        where u.Id == id
                        select new UserDTO
                        {
                            Id = u.Id,
                            UserName = u.UserName,
                            NickName = u.NickName,
                            Password = u.Password
                        }).SingleOrDefault();

            }
            return user;
        }

        public UserDTO Login(string username, string password)
        {
            UserDTO user = null;

            using (dbContext = new DbEntities())
            {
                //user = (from u in dbContext.Users
                //        where
                //        u.UserName == username
                //        &&
                //        u.Password == password
                //        select new UserDTO
                //        {
                //            Id = u.Id,
                //            NickName = u.NickName,
                //            UserName = u.UserName,
                //            Password = u.Password
                //        }).FirstOrDefault();


                user = dbContext
                    .Users
                    .Where(u => u.UserName == username && u.Password == password)
                    .Select(u => new UserDTO
                    {
                        Id = u.Id,
                        UserName = u.UserName,
                        Password = u.Password,
                        NickName = u.NickName
                    })
                    .SingleOrDefault();
            }

            return user;
        }
    }
}
