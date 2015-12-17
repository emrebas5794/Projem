using Calisma_DAL;
using Calisma_DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CalismaBLL
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
                user.Name = item.Name;
                user.Surname = item.Surname;
                user.Email = item.Email;
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

        public int Delete(int id)
        {
            int result = 0;

            using (dbContext = new DbEntities())
            {

                User categoryEntity = new User();
                categoryEntity.id = id;


                dbContext.Entry(categoryEntity).State = System.Data.Entity.EntityState.Deleted;

                try
                {
                    result = dbContext.SaveChanges();
                }
                catch (Exception)
                {
                    result = -1;
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
                        where u.id == item.id
                        select u
                        ).SingleOrDefault();
                user.Name = item.Name;
                user.Surname = item.Surname;
                user.Email = item.Email;
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
                                id= u.id,
                                Name = u.Name,
                                Surname = u.Surname,
                                Email = u.Email
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
                        where u.id == id
                        select new UserDTO
                        {
                            id = u.id,
                             Name = u.Name,
                             Surname = u.Surname,
                             Email = u.Email


                        }).SingleOrDefault();

            }
            return user;
        }
        public UserDTO Login(string email)
        {
            UserDTO user = null;

            using (dbContext = new DbEntities())
            {
         


                user = dbContext
                    .Users
                    .Where(u => u.Email == email)
                    .Select(u => new UserDTO
                    {
                        id = u.id,
                        Name = u.Name,
                        Surname = u.Surname,
                        Email = u.Email
                    })
                    .SingleOrDefault();
            }

            return user;
        }

    }
}
