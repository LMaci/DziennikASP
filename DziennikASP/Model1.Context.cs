﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DziennikASP
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class DziennikEntities : DbContext
    {
        public DziennikEntities()
            : base("name=DziennikEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<AUTH> AUTH { get; set; }
        public virtual DbSet<DANE_OSOBOWE> DANE_OSOBOWE { get; set; }
        public virtual DbSet<GRUPA> GRUPA { get; set; }
        public virtual DbSet<KIERUNEK> KIERUNEK { get; set; }
        public virtual DbSet<PRACOWNIK> PRACOWNIK { get; set; }
        public virtual DbSet<PROJEKT> PROJEKT { get; set; }
        public virtual DbSet<PRZEDMIOT> PRZEDMIOT { get; set; }
        public virtual DbSet<SL_STANOWISKO> SL_STANOWISKO { get; set; }
        public virtual DbSet<STUDENT> STUDENT { get; set; }
        public virtual DbSet<STUDENT_PRZEDMIOT> STUDENT_PRZEDMIOT { get; set; }
    }
}
