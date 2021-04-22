using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace R2PTransformation.Models
{
    public partial class AzureContext : DbContext
    {
        public AzureContext()
        {
        }

        public AzureContext(DbContextOptions<AzureContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Batch> Batch { get; set; }
        public virtual DbSet<Conversion> Conversion { get; set; }
        public virtual DbSet<CustodyTicket> CustodyTicket { get; set; }
        public virtual DbSet<InventorySnapshot> InventorySnapshot { get; set; }
        public virtual DbSet<MaterialLedger> MaterialLedger { get; set; }
        public virtual DbSet<MaterialMovement> MaterialMovement { get; set; }
        public virtual DbSet<ProductHierarchy> ProductHierarchy { get; set; }
        public virtual DbSet<SourceUnitMap> SourceUnitMap { get; set; }
        public virtual DbSet<StandardUnit> StandardUnit { get; set; }
        public virtual DbSet<TagBalance> TagBalance { get; set; }
        public virtual DbSet<TagMap> TagMap { get; set; }
        public virtual DbSet<TransactionEvent> TransactionEvent { get; set; }
        public virtual DbSet<TransactionEventDetail> TransactionEventDetail { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseSqlServer("Data Source=inmdevarmsvruw2001.database.windows.net;Initial Catalog=inmdevarmsqluw2001;User ID=suncorsqladmin;password=AdvancedAnalytics2020");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Batch>(entity =>
            {
                entity.Property(e => e.Id)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Created).HasColumnType("datetime");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Filename)
                    .HasColumnName("filename")
                    .HasMaxLength(200)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Conversion>(entity =>
            {
                entity.HasKey(e => new { e.Material, e.StandardUnit, e.ToUnit });

                entity.Property(e => e.Material)
                    .HasColumnName("material")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.StandardUnit)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.ToUnit)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Factor).HasColumnType("decimal(18, 8)");

                entity.HasOne(d => d.StandardUnitNavigation)
                    .WithMany(p => p.ConversionStandardUnitNavigation)
                    .HasForeignKey(d => d.StandardUnit)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Conversion_StandardUnit1");

                entity.HasOne(d => d.ToUnitNavigation)
                    .WithMany(p => p.ConversionToUnitNavigation)
                    .HasForeignKey(d => d.ToUnit)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Conversion_StandardUnit");
            });

            modelBuilder.Entity<CustodyTicket>(entity =>
            {
                entity.Property(e => e.CustodyTicketId).HasColumnName("custodyTicket_id");

                entity.Property(e => e.BolNumber)
                    .IsRequired()
                    .HasColumnName("BOL_Number")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Density).HasColumnType("decimal(10, 5)");

                entity.Property(e => e.DocumentDateTime)
                    .HasColumnName("Document_DateTime")
                    .HasColumnType("datetime");

                entity.Property(e => e.EnteredBy)
                    .IsRequired()
                    .HasColumnName("Entered_by")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.EnteredOnDateTime)
                    .HasColumnName("Entered_On_DateTime")
                    .HasColumnType("datetime");

                entity.Property(e => e.GrossQuantitySize)
                    .HasColumnName("Gross_Quantity_Size")
                    .HasColumnType("decimal(10, 5)");

                entity.Property(e => e.LoadEndDateTime)
                    .HasColumnName("Load_End_DateTime")
                    .HasColumnType("datetime");

                entity.Property(e => e.LoadStartDate)
                    .IsRequired()
                    .HasColumnName("Load_Start_Date")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.LoadStartTime)
                    .IsRequired()
                    .HasColumnName("Load_Start_Time")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Mode)
                    .IsRequired()
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.MovementPlant)
                    .IsRequired()
                    .HasColumnName("Movement_Plant")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.MovementType)
                    .IsRequired()
                    .HasColumnName("Movement_Type")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.NetQuantitySize)
                    .HasColumnName("Net_Quantity_Size")
                    .HasColumnType("decimal(10, 5)");

                entity.Property(e => e.PostingDateTime)
                    .HasColumnName("Posting_DateTime")
                    .HasColumnType("datetime");

                entity.Property(e => e.ReceivingPlant)
                    .IsRequired()
                    .HasColumnName("Receiving_Plant")
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.S4Material)
                    .IsRequired()
                    .HasColumnName("S4_Material")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.S4MaterialDocument)
                    .IsRequired()
                    .HasColumnName("S4_Material_Document")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.SendingPlant)
                    .IsRequired()
                    .HasColumnName("Sending_Plant")
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Sign)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.SourceDataMaterialCode)
                    .IsRequired()
                    .HasColumnName("Source_Data_Material_Code")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Temperature)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.UnitOfMeasure)
                    .IsRequired()
                    .HasColumnName("Unit_of_Measure")
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.ValuationType)
                    .IsRequired()
                    .HasColumnName("Valuation_Type")
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.HasOne(d => d.UnitOfMeasureNavigation)
                    .WithMany(p => p.CustodyTicket)
                    .HasForeignKey(d => d.UnitOfMeasure)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CustodyTicket_Unit_of_Measure");
            });

            modelBuilder.Entity<InventorySnapshot>(entity =>
            {
                entity.HasKey(e => new { e.Tag, e.ValType, e.QuantityTimestamp, e.Tank });

                entity.Property(e => e.Tag)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.ValType)
                    .HasMaxLength(30)
                    .IsUnicode(false);

                entity.Property(e => e.QuantityTimestamp).HasColumnType("datetime");

                entity.Property(e => e.Tank)
                    .HasMaxLength(30)
                    .IsUnicode(false);

                entity.Property(e => e.BatchId)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Confidence).HasColumnType("decimal(18, 3)");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.LastUpdated)
                    .HasColumnName("lastUpdated")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Material)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.MovementType)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Plant)
                    .HasMaxLength(30)
                    .IsUnicode(false);

                entity.Property(e => e.Quantity).HasColumnType("decimal(18, 4)");

                entity.Property(e => e.StandardUnit)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.System)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.WorkCenter)
                    .HasMaxLength(30)
                    .IsUnicode(false);

                entity.HasOne(d => d.Batch)
                    .WithMany(p => p.InventorySnapshot)
                    .HasForeignKey(d => d.BatchId)
                    .HasConstraintName("FK_InventorySnapshot_Batch");

                entity.HasOne(d => d.StandardUnitNavigation)
                    .WithMany(p => p.InventorySnapshot)
                    .HasForeignKey(d => d.StandardUnit)
                    .HasConstraintName("FK_InventorySnapshot_StandardUnit");
            });

            modelBuilder.Entity<MaterialLedger>(entity =>
            {
                entity.HasKey(e => new { e.Plant, e.CoCode });

                entity.Property(e => e.Plant)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.CoCode)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.PreviousPeriodOpen)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Status)
                    .HasMaxLength(5)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<MaterialMovement>(entity =>
            {
                entity.Property(e => e.MaterialMovementId).HasColumnName("MaterialMovement_id");

                entity.Property(e => e.BatchId)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.EnteredAt)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.EnteredOn).HasColumnType("datetime");

                entity.Property(e => e.HeaderText)
                    .HasMaxLength(1000)
                    .IsUnicode(false);

                entity.Property(e => e.MaterialDocument)
                    .IsRequired()
                    .HasColumnName("materialDocument")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.MovementType)
                    .HasMaxLength(30)
                    .IsUnicode(false);

                entity.Property(e => e.MovementTypeDesc)
                    .HasMaxLength(800)
                    .IsUnicode(false);

                entity.Property(e => e.Plant)
                    .HasMaxLength(30)
                    .IsUnicode(false);

                entity.Property(e => e.PostingDate).HasColumnType("datetime");

                entity.Property(e => e.Quantity).HasColumnType("decimal(18, 4)");

                entity.Property(e => e.QuantityInL15).HasColumnType("decimal(18, 4)");

                entity.Property(e => e.QuantityInUoe)
                    .HasColumnName("QuantityInUOE")
                    .HasColumnType("decimal(18, 4)");

                entity.Property(e => e.System)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Tag)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.UnitOfEntry)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.UnitOfMeasure)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.ValuationType)
                    .HasMaxLength(30)
                    .IsUnicode(false);

                entity.HasOne(d => d.UnitOfEntryNavigation)
                    .WithMany(p => p.MaterialMovementUnitOfEntryNavigation)
                    .HasForeignKey(d => d.UnitOfEntry)
                    .HasConstraintName("FK_MaterialMovement_UnitOfEntry");

                entity.HasOne(d => d.UnitOfMeasureNavigation)
                    .WithMany(p => p.MaterialMovementUnitOfMeasureNavigation)
                    .HasForeignKey(d => d.UnitOfMeasure)
                    .HasConstraintName("FK_MaterialMovement_UnitOfMeasure");
            });

            modelBuilder.Entity<ProductHierarchy>(entity =>
            {
                entity.HasKey(e => e.S4material);

                entity.Property(e => e.S4material)
                    .HasColumnName("S4Material")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.EnteredAt)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.EnteredOn)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.MaterialDescription)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.MaterialGroup)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.MaterialGroupText)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.ProductHierarchyLevel1Code)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.ProductHierarchyLevel1Text)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.ProductHierarchyLevel2Code)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.ProductHierarchyLevel2Text)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.ProductHierarchyLevel3Code)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.ProductHierarchyLevel3Text)
                    .HasMaxLength(100)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<SourceUnitMap>(entity =>
            {
                entity.HasKey(e => new { e.Source, e.SourceUnit })
                    .HasName("PK_UomMap");

                entity.Property(e => e.Source)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.SourceUnit)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.StandardUnit)
                    .IsRequired()
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.HasOne(d => d.StandardUnitNavigation)
                    .WithMany(p => p.SourceUnitMap)
                    .HasForeignKey(d => d.StandardUnit)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_StandardUnit_Name");
            });

            modelBuilder.Entity<StandardUnit>(entity =>
            {
                entity.HasKey(e => e.Name);

                entity.Property(e => e.Name)
                    .HasMaxLength(10)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<TagBalance>(entity =>
            {
                entity.HasKey(e => new { e.Tag, e.BalanceDate, e.ValType });

                entity.Property(e => e.Tag)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.BalanceDate).HasColumnType("datetime");

                entity.Property(e => e.ValType)
                    .HasMaxLength(30)
                    .IsUnicode(false);

                entity.Property(e => e.BatchId)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.ClosingInventory).HasColumnType("decimal(18, 3)");

                entity.Property(e => e.Consumption)
                    .HasColumnName("consumption")
                    .HasColumnType("decimal(18, 3)");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.LastUpdated)
                    .HasColumnName("lastUpdated")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Material)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.MovementType)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.OpeningInventory).HasColumnType("decimal(18, 3)");

                entity.Property(e => e.Plant)
                    .HasMaxLength(30)
                    .IsUnicode(false);

                entity.Property(e => e.Quantity).HasColumnType("decimal(18, 4)");

                entity.Property(e => e.Receipt).HasColumnType("decimal(18, 3)");

                entity.Property(e => e.Shipment).HasColumnType("decimal(18, 3)");

                entity.Property(e => e.StandardUnit)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.System)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.WorkCenter)
                    .HasMaxLength(30)
                    .IsUnicode(false);

                entity.HasOne(d => d.Batch)
                    .WithMany(p => p.TagBalance)
                    .HasForeignKey(d => d.BatchId)
                    .HasConstraintName("FK_TagBalance_Batch");

                entity.HasOne(d => d.StandardUnitNavigation)
                    .WithMany(p => p.TagBalance)
                    .HasForeignKey(d => d.StandardUnit)
                    .HasConstraintName("FK_TagBalance_StandardUnit");
            });

            modelBuilder.Entity<TagMap>(entity =>
            {
                entity.HasKey(e => new { e.Tag, e.Plant });

                entity.Property(e => e.Tag)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.Plant)
                    .HasMaxLength(4)
                    .IsUnicode(false);

                entity.Property(e => e.DefaultUnit)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.DefaultValuationType)
                    .IsRequired()
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.MaterialNumber)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.WorkCenter)
                    .IsRequired()
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.HasOne(d => d.DefaultUnitNavigation)
                    .WithMany(p => p.TagMap)
                    .HasForeignKey(d => d.DefaultUnit)
                    .HasConstraintName("FK_TagMap_StandardUnit");
            });

            modelBuilder.Entity<TransactionEvent>(entity =>
            {
                entity.Property(e => e.TransactionEventId).HasColumnName("TransactionEvent_id");

                entity.Property(e => e.CreateDate)
                    .HasColumnName("createDate")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Extra)
                    .HasColumnName("extra")
                    .HasMaxLength(8000)
                    .IsUnicode(false);

                entity.Property(e => e.FailedRecordCount).HasColumnName("failedRecordCount");

                entity.Property(e => e.Filename)
                    .HasColumnName("filename")
                    .HasMaxLength(500)
                    .IsUnicode(false);

                entity.Property(e => e.Message)
                    .HasColumnName("message")
                    .HasMaxLength(3000)
                    .IsUnicode(false);

                entity.Property(e => e.Plant)
                    .HasColumnName("plant")
                    .HasMaxLength(40)
                    .IsUnicode(false);

                entity.Property(e => e.SuccessfulRecordCount).HasColumnName("successfulRecordCount");

                entity.Property(e => e.Type)
                    .HasColumnName("type")
                    .HasMaxLength(20)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<TransactionEventDetail>(entity =>
            {
                entity.Property(e => e.TransactionEventDetailId).HasColumnName("TransactionEventDetail_id");

                entity.Property(e => e.Message)
                    .IsRequired()
                    .HasColumnName("message")
                    .HasMaxLength(3000)
                    .IsUnicode(false);

                entity.Property(e => e.Tag)
                    .HasColumnName("tag")
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.TransactionEventId).HasColumnName("TransactionEvent_id");

                entity.Property(e => e.Type)
                    .IsRequired()
                    .HasColumnName("type")
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.HasOne(d => d.TransactionEvent)
                    .WithMany(p => p.TransactionEventDetail)
                    .HasForeignKey(d => d.TransactionEventId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_transactioneventdetail");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
