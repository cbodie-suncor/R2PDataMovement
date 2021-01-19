using Microsoft.Extensions.Configuration;
using R2PTransformation.src.db;
using System;

namespace R2PTransformation {
    class Program {
        static void Main(string[] args) {
            Console.WriteLine("Hello World!");
            /*
            var newbuilder = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json");
                */
            IConfiguration iconfig = new ConfigurationBuilder()
                .AddJsonFile("appsettings.json", true, true)
                .Build();

//            AzureModel.SetConnection(iconfig["ConnectionStrings:DataHub"]);

            Console.WriteLine($" Hello { iconfig["fullname"] } !");
        }
    }
}
