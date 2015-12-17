using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CafeBlog.DAL
{
    public interface IRepository<T>
    {
        T GetById(int id);
        List<T> GetAll();
        int Insert(T item);
        int Update(T item);
        int Delete(int id);
    }
}
