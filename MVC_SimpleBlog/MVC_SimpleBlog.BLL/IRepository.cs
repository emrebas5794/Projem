using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MVC_SimpleBlog.BLL
{
     interface IRepository<T>
     {
          int Insert(T item);
          int Delete(T item);
          int Update(T item);
          List<T> GetAll();
          T GetById(int id);
     }
}
