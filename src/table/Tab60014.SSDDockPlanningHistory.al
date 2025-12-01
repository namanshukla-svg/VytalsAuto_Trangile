table 60014 "SSD Dock Planning History"
{
    Caption = 'Dock Planning History';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(10; "Dock No."; Code[20])
        {
            Caption = 'Dock No.';
            TableRelation = "SSD Dock" where("Location Code"=field("Location Code"));
        }
        field(20; "Time Slot No."; Code[20])
        {
            Caption = 'Time Slot No.';
            TableRelation = "SSD Dock Time Slots"."Slot No." where("Location Code"=field("Location Code"), "Dock No."=field("Dock No."));
        }
        field(30; "Planning Date"; Date)
        {
            Caption = 'Planning Date';
        }
        field(31; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(50; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(60; "Pallet Count"; Integer)
        {
            Caption = 'Pallet Count';
        }
        field(100; "Item Description"; Text[100])
        {
            Caption = 'Item Description';
        }
        field(110; "Base Unit of Measure"; Code[20])
        {
            Caption = 'Base Unit of Measure';
        }
        field(500; "Record Synced"; Boolean)
        {
            Caption = 'Record Synced';
        }
        field(1000; "Deleted By"; Code[50])
        {
            Caption = 'Deleted By';
            TableRelation = User;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Location Code", "Dock No.", "Time Slot No.", "Planning Date", "Item No.")
        {
            Clustered = true;
        }
    }
}
