using System;
using System.Linq;
using Microsoft.EntityFrameworkCore;

namespace MusicDataBase
{
    class Program
    {
        static void Main(string[] args)
        {
            static string PromptForString(string prompt)
            {
                Console.Write(prompt);
                var userInput = Console.ReadLine();

                return userInput;
            }

            static bool PromptForBoolean(string prompt)
            {
                Console.Write(prompt);
                bool userInput;
                var isThisGoodInput = bool.TryParse(Console.ReadLine(), out userInput);

                if (userInput = true || false)
                {
                    return userInput;
                }
                else
                {
                    Console.WriteLine("Sorry, that isn't a valid input, I'm using false as your answer.");
                    return false;
                }
            }

            static DateTime PromptForDateTime(string prompt)
            {
                Console.Write(prompt);
                var userInput = Console.ReadLine();
                var userInputDateTime = Convert.ToDateTime(userInput);

                return userInputDateTime;
            }

            static int PromptForInteger(string prompt)
            {
                Console.Write(prompt);
                int userInput;
                var isThisGoodInput = Int32.TryParse(Console.ReadLine(), out userInput);

                if (isThisGoodInput)
                {
                    return userInput;
                }
                else
                {
                    Console.WriteLine("Sorry, that isn't a valid input, I'm using 0 as your answer.");
                    return 0;
                }
            }

            var context = new MusicDataBaseContext();

            var albums = context.Albums.Include(album => album.Band);
            var bands = context.Bands;
            var youChooseToQuit = false;

            Console.WriteLine("------------------------------------------------");
            Console.WriteLine($"Welcome to the official World Music Database");
            Console.WriteLine("------------------------------------------------ \n\n");
            while (youChooseToQuit == false)
            {
                Console.WriteLine($"\n Please choose one of the below options \n");

                Console.WriteLine($"(A) - Add a New Band \n");
                Console.WriteLine($"(B) - View All Bands \n");
                Console.WriteLine($"(C) - Add an Album for a Band \n");
                Console.WriteLine($"(D) - Let a Band Go \n");
                Console.WriteLine($"(E) - Resign a Band \n");
                Console.WriteLine($"(F) - View all Albums from a Band \n");
                Console.WriteLine($"(G) - View all Albums by Release Date \n");
                Console.WriteLine($"(H) - View all Bands that are Signed \n");
                Console.WriteLine($"(I) - View all Unsigned Bands \n");
                Console.WriteLine($"(J) - To quit \n");

                var toChoose = PromptForString($"Choose: ");

                // exit the application
                if (toChoose == "J")
                {
                    youChooseToQuit = true;
                    Console.WriteLine($"Thank you for visiting the World Music Database! Come again soon!");
                    Console.WriteLine();
                }
                //Add a new band  
                if (toChoose == "A")
                {
                    var bandName = PromptForString($"Band Name: ");
                    var countryOfOrigin = PromptForString($"Country of Origin: ");
                    var numberOfMembers = PromptForInteger($"Number of Members: ");
                    var bandWebsite = PromptForString($"Website: ");
                    var bandStyle = PromptForString($"Style: ");
                    var bandIsSigned = PromptForBoolean($"Is Signed (true or false): ");
                    var bandContactName = PromptForString($"Contact Name: ");
                    var bandContactPhoneNumber = PromptForInteger($"Contact Phone Number: ");

                    var newBand = new Band
                    {
                        Name = bandName,
                        CountryOfOrigin = countryOfOrigin,
                        NumberOfMembers = numberOfMembers,
                        Website = bandWebsite,
                        Style = bandStyle,
                        IsSigned = bandIsSigned,
                        ContactName = bandContactName,
                        ContactPhoneNumber = bandContactPhoneNumber
                    };

                    context.Bands.Add(newBand);
                    context.SaveChanges();
                }
                //  View all the bands
                if (toChoose == "B")
                {
                    var bandCount = bands.Count();
                    Console.WriteLine($"There are {bands.Count()} bands in the system");
                    Console.WriteLine($"They are:\n");

                    foreach (var band in bands)
                    {
                        Console.WriteLine($"{band.Name}");
                    }
                }
                //  Add an album for a band
                if (toChoose == "C")
                {
                    var bandToChoose = PromptForString($"Name of Band: ");
                    var bandThatWasChoosen = bands.FirstOrDefault(band => band.Name == bandToChoose);

                    var albumTitle = PromptForString($"Album Title: ");
                    var albumIsExplicit = PromptForBoolean($"Is Explicit (true or false): ");
                    var albumReleaseDate = PromptForDateTime($"Release Date (YYYY-MM-DD): ");

                    var newAlbum = new Album
                    {
                        Title = albumTitle,
                        IsExplicit = albumIsExplicit,
                        ReleaseDate = albumReleaseDate,
                        BandId = bandThatWasChoosen.Id
                    };
                    context.Albums.Add(newAlbum);
                    context.SaveChanges();
                }
                //  Let a band go (update isSigned to false)
                if (toChoose == "D")
                {
                    var bandToLetGo = PromptForString($"Name of Band: \n");
                    var bandThatWasChoosen = bands.FirstOrDefault(band => band.Name == bandToLetGo);
                    if (bandThatWasChoosen != null)
                    {
                        bandThatWasChoosen.IsSigned = false;

                        context.SaveChanges();
                    }
                    else
                    {
                        Console.WriteLine($"I'm sorry that Band is not in our system. Please choose again.");
                    }
                }
                //  Resign a band (update isSigned to true)
                if (toChoose == "E")
                {
                    var bandToSign = PromptForString($"Name of Band: \n");
                    var bandThatWasChoosen = bands.FirstOrDefault(band => band.Name == bandToSign);
                    if (bandThatWasChoosen != null)
                    {
                        bandThatWasChoosen.IsSigned = true;

                        context.SaveChanges();
                    }
                    else
                    {
                        Console.WriteLine($"I'm sorry that Band is not in our system. Please choose again.");
                    }
                }
                //  Prompt for a band name and view all their albums
                if (toChoose == "F")
                {
                    var bandToChoose = PromptForString($"Name of Band: ");
                    var bandThatWasChoosen = bands.FirstOrDefault(band => band.Name == bandToChoose);

                    if (bandThatWasChoosen == null)
                    {
                        Console.WriteLine($"I'm sorry that band is not in our system. Please choose again.");
                    }

                    else
                    {
                        var theBandsAlbums = albums.Where(album => album.BandId == bandThatWasChoosen.Id);

                        foreach (var album in theBandsAlbums)
                        {
                            Console.WriteLine($"{album.Title}, release date {album.ReleaseDate}");
                        }
                    }
                }
                //  View all albums ordered by ReleaseDate
                if (toChoose == "G")
                {
                    var albumsByReleaseDate = albums.OrderBy(albums => albums.ReleaseDate);
                    foreach (var album in albumsByReleaseDate)
                    {
                        Console.WriteLine($"{album.Band.Name} --- {album.Title} --- {album.ReleaseDate} \n");
                    }
                }
                //  View all bands that are signed
                if (toChoose == "H")
                {
                    var bandsThatAreSigned = bands.Where(bands => bands.IsSigned == true);
                    foreach (var band in bandsThatAreSigned)
                    {
                        Console.WriteLine($"{band.Name} --- {band.IsSigned} \n");
                    }
                }
                //  View all bands that are not signed
                if (toChoose == "I")
                {
                    var bandsThatAreNotSigned = bands.Where(bands => bands.IsSigned == false);
                    foreach (var band in bandsThatAreNotSigned)
                    {
                        Console.WriteLine($"{band.Name} --- {band.IsSigned} \n");
                    }
                }

            }
        }
    }
}
