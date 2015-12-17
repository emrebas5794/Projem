using Calisma_DAL;
using Calisma_DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CalismaBLL
{
    public class CategoryRepository: IRepository<CategoryDTO>
    {
        DbEntities dbContext;

        public CategoryDTO GetById(int id)
        {
            CategoryDTO category = null;

            using (dbContext = new DbEntities())
            {
                category = (from c in dbContext.Categorys
                            where c.id == id
                            select new CategoryDTO
                            {
                                id = c.id,
                                CategoryName = c.CategoryName
                            }).SingleOrDefault();
            }

            return category;
        }

        public List<CategoryDTO> GetAll()
        {
            List<CategoryDTO> categoryList = null;

            using (dbContext = new DbEntities())
            {
                categoryList = (from c in dbContext.Categorys
                                select new CategoryDTO
                                {
                                    id = c.id,
                                    CategoryName = c.CategoryName
                                }).ToList();
            }

            return categoryList;
        }

        public int Insert(CategoryDTO item)
        {
            int result = 0;

            using (dbContext = new DbEntities())
            {
                Category categoryEntity = new Category();
                categoryEntity.id = item.id;
                categoryEntity.CategoryName = item.CategoryName;

              

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

            using (dbContext = new DbEntities())
            {
             

               
                Category categoryEntity = new Category();
                categoryEntity.id = item.id;
                categoryEntity.CategoryName = item.CategoryName;

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

            using (dbContext = new DbEntities())
            {
              
                Category categoryEntity = new Category();
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

       
    }
}
