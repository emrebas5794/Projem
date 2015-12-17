using CafeBlog.DAL;
using CafeBlog.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CafeBlog.BLL
{
    public class CategoryRepository : IRepository<CategoryDTO>
    {
        BlogContext dbContext;

        public CategoryDTO GetById(int id)
        {
            CategoryDTO category = null;

            using (dbContext = new BlogContext())
            {
                category = (from c in dbContext.Category
                               where c.Id == id
                               select new CategoryDTO
                               {
                                   Id = c.Id,
                                   Name = c.Name
                               }).SingleOrDefault();
            }

            return category;
        }

        public List<CategoryDTO> GetAll()
        {
            List<CategoryDTO> categoryList = null;

            using (dbContext = new BlogContext())
            {
                categoryList = (from c in dbContext.Category
                                select new CategoryDTO
                                {
                                    Id = c.Id,
                                    Name = c.Name
                                }).ToList();
            }

            return categoryList;
        }

        public int Insert(CategoryDTO item)
        {
            int result = 0;

            using (dbContext = new BlogContext())
            {
                Category categoryEntity = new Category();
                categoryEntity.Id = item.Id;
                categoryEntity.Name = item.Name;

                //dbContext.Category.Add(categoryEntity);

                //dbContext.Category.Attach(categoryEntity);

                dbContext.Entry(categoryEntity).State = System.Data.Entity.EntityState.Added;

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

        public int Update(CategoryDTO item)
        {
            int result = 0;

            using (dbContext = new BlogContext())
            {
                // Klasik yöntem
                //Category categoryEntity = dbContext.Category.Single(c => c.Id == item.Id);
                //categoryEntity.Name = item.Name;


                // Yeni yöntem
                Category categoryEntity = new Category();
                categoryEntity.Id = item.Id;
                categoryEntity.Name = item.Name;

                //dbContext.Category.Attach(categoryEntity);

                dbContext.Entry(categoryEntity).State = System.Data.Entity.EntityState.Modified;

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

        public int Delete(int id)
        {
            int result = 0;

            using (dbContext = new BlogContext())
            {
                //Category categoryEntity = dbContext.Category.Single(c => c.Id == id);

                //dbContext.Category.Remove(categoryEntity);

                Category categoryEntity = new Category();
                categoryEntity.Id = id;

                // dbContext.Category.Attach(categoryEntity);
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
    }
}
