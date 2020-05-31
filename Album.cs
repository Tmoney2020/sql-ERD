using System;

namespace MusicDataBase
{
    class Album
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public Boolean IsExplicit { get; set; }
        public DateTime ReleaseDate { get; set; }
        public int BandId { get; set; }
        public Band Band { get; set; }

    }

}