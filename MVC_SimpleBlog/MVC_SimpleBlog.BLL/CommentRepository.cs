using MVC_SimpleBlog.DAL;
using MVC_SimpleBlog.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MVC_SimpleBlog.BLL
{
     public class CommentRepository : IRepository<CommentDTO>
     {
          DbEntities dbContext;
          public int Insert(CommentDTO item)
          {
               int result = 0;
               using (dbContext = new DbEntities())
               {
                    Comment comment = new Comment();
                    comment.ArticleId = item.ArticleId;
                    comment.CommentDate = item.CommentDate;
                    comment.Content = item.Content;
                    comment.Title = item.Title;
                    comment.UserId = item.UserId;
                    dbContext.Comments.Add(comment);
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

          public int Delete(CommentDTO item)
          {
               int result = 0;
               Comment comment = null;
               using (dbContext = new DbEntities())
               {
                    comment = (from u in dbContext.Comments
                               where u.Id == item.Id
                               select u).SingleOrDefault();
                    dbContext.Comments.Remove(comment);

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

          public int Update(CommentDTO item)
          {
               Comment comment = null;
               int result = 0;
               using (dbContext = new DbEntities())
               {
                    comment = (from u in dbContext.Comments
                               where u.Id == item.Id
                               select u
                            ).SingleOrDefault();
                    comment.ArticleId = item.ArticleId;
                    comment.CommentDate = item.CommentDate;
                    comment.Content = item.Content;
                    comment.Title = item.Title;
                    comment.UserId = item.UserId;
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

          public List<CommentDTO> GetAll()
          {
               List<CommentDTO> commentList = null;
               using (dbContext = new DbEntities())
               {
                    commentList = (from u in dbContext.Comments
                                   select new CommentDTO
                                   {
                                        Id = u.Id,
                                        ArticleId = u.ArticleId,
                                        UserId = u.UserId,
                                        Title = u.Title,
                                        Content = u.Title,
                                        CommentDate = u.CommentDate
                                   }).ToList();
               }
               return commentList;
          }

          public CommentDTO GetById(int id)
          {
               CommentDTO comment = null;
               using (dbContext = new DbEntities())
               {
                    comment = (from u in dbContext.Comments
                               where u.Id == id
                               select new CommentDTO
                               {
                                    Id = u.Id,
                                    ArticleId = u.ArticleId,
                                    CommentDate = u.CommentDate,
                                    Content = u.Content,
                                    Title = u.Title,
                                    UserId = u.UserId
                               }).SingleOrDefault();

               }
               return comment;
          }
     }
}
