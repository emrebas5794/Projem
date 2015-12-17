using MVC_SimpleBlog.DAL;
using MVC_SimpleBlog.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MVC_SimpleBlog.BLL
{
     class ContactMessageRepository : IRepository<ContactMessageDTO>
     {
          DbEntities dbContext;
          public int Insert(ContactMessageDTO item)
          {
               int result = 0;
               using (dbContext = new DbEntities())
               {
                    ContactMessage contactMessage = new ContactMessage();
                    contactMessage.EmailAddress = item.EmailAddress;
                    contactMessage.Message = item.Message;
                    contactMessage.Name = item.Name;
                    contactMessage.PhoneNumber = item.PhoneNumber;
                    dbContext.ContactMessages.Add(contactMessage);
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

          public int Delete(ContactMessageDTO item)
          {
               int result = 0;
               ContactMessage contactMessage = null;
               using (dbContext = new DbEntities())
               {
                    contactMessage = (from u in dbContext.ContactMessages
                                      where u.Id == item.Id
                                      select u).SingleOrDefault();
                    dbContext.ContactMessages.Remove(contactMessage);

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

          public int Update(ContactMessageDTO item)
          {
               ContactMessage contactMessage = null;
               int result = 0;
               using (dbContext = new DbEntities())
               {
                    contactMessage = (from c in dbContext.ContactMessages
                                      where c.Id == item.Id
                                      select c
                            ).SingleOrDefault();
                    contactMessage.EmailAddress = item.EmailAddress;
                    contactMessage.Message = item.Message;
                    contactMessage.Name = item.Name;
                    contactMessage.PhoneNumber = item.PhoneNumber;
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

          public List<ContactMessageDTO> GetAll()
          {
               List<ContactMessageDTO> ContactMessageList = null;
               using (dbContext = new DbEntities())
               {
                    ContactMessageList = (from c in dbContext.ContactMessages
                                          select new ContactMessageDTO
                                          {
                                               Id = c.Id,
                                               EmailAddress = c.EmailAddress,
                                               Message = c.Message,
                                               Name = c.Name,
                                               PhoneNumber = c.PhoneNumber
                                          }).ToList();
               }
               return ContactMessageList;
          }

          public ContactMessageDTO GetById(int id)
          {
               ContactMessageDTO contactMessage = null;
               using (dbContext = new DbEntities())
               {
                    contactMessage = (from c in dbContext.ContactMessages
                                      where c.Id == id
                                      select new ContactMessageDTO
                                      {
                                           Id = c.Id,
                                           EmailAddress = c.EmailAddress,
                                           Message = c.Message,
                                           Name = c.Name,
                                           PhoneNumber = c.PhoneNumber
                                      }).SingleOrDefault();

               }
               return contactMessage;
          }
     }
}
