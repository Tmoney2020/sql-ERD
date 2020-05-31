
using Microsoft.EntityFrameworkCore;

namespace MusicDataBase
{
    class MusicDataBaseContext : DbContext
    {
        public DbSet<Album> Albums { get; set; }
        public DbSet<Band> Bands { get; set; }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseNpgsql("server=localhost;database=MusicDataBase");

        }
    }
}