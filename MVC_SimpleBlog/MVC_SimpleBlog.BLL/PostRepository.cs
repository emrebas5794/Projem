using MVC_SimpleBlog.DAL;
using MVC_SimpleBlog.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MVC_SimpleBlog.BLL
{
    public class PostRepository : IRepository<PostDTO>
    {
        DbEntities dbContext;

        public int Insert(PostDTO item)
        {
            int result = 0;
            using (dbContext = new DbEntities())
            {
                Post post = new Post();
                post.ImagePath = item.ImagePath;
                post.Title = item.Title;
                post.Content = item.Content;
                post.CategoryId = item.CategoryId;

                post.UserId = 1;
                post.CreatedDate = DateTime.Now;

                //dbContext.Posts.Add(post);

                //dbContext.Posts.Attach(post);
                dbContext.Entry(post).State = System.Data.Entity.EntityState.Added;

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

        public int Delete(PostDTO item)
        {
            int result = 0;
            Post article = null;
            using (dbContext = new DbEntities())
            {
                article = (from a in dbContext.Posts
                           where a.Id == item.Id
                           select a).SingleOrDefault();

                //dbContext.Posts.Remove(article);

                dbContext.Posts.Attach(article);
                dbContext.Entry(article).State = System.Data.Entity.EntityState.Deleted;

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

        public int Update(PostDTO item)
        {
            Post post = null;
            int result = 0;

            using (dbContext = new DbEntities())
            {
                //post = (from a in dbContext.Posts
                //           where a.Id == item.Id
                //           select a).SingleOrDefault();

                post = new Post();
                post.Id = item.Id;
                post.Title = item.Title;
                post.Content = item.Content;
                post.ImagePath = item.ImagePath;
                post.CategoryId = item.CategoryId;

                post.CreatedDate = item.CreatedDate;
                post.UserId = item.UserId;

                dbContext.Posts.Attach(post);
                dbContext.Entry(post).State = System.Data.Entity.EntityState.Modified;

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

        public List<PostDTO> GetAll()
        {
            List<PostDTO> articleList = null;
            using (dbContext = new DbEntities())
            {
                articleList = (from a in dbContext.Posts
                               select new PostDTO
                               {
                                   Id = a.Id,
                                   Content = a.Content,
                                   CreatedDate = a.CreatedDate,
                                   ImagePath = a.ImagePath,
                                   CategoryId = a.CategoryId,
                                   Title = a.Title,
                                   UserId = a.UserId

                               }).ToList();
            }
            return articleList;
        }

        public PostDTO GetById(int id)
        {
            PostDTO article = null;
            using (dbContext = new DbEntities())
            {
                article = (from a in dbContext.Posts
                           where a.Id == id
                           select new PostDTO
                           {
                               Id = a.Id,
                               Content = a.Content,
                               CreatedDate = a.CreatedDate,
                               ImagePath = a.ImagePath,
                               CategoryId = a.CategoryId,
                               Title = a.Title,
                               UserId = a.UserId
                           }).SingleOrDefault();

            }
            return article;
        }
    }
}
