table 60013 "SSD WMS Sync Status"
{
    Caption = 'WMS Sync Status';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(5; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(10; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(20; "Lot No."; Code[50])
        {
            Caption = 'Lot No. ';
        }
        field(30; "Package No."; Code[50])
        {
            Caption = 'Package No.';
        }
        field(40; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(50; "Qty. (Base)"; Decimal)
        {
            Caption = 'Qty. (Base)';
        }
        field(60; Status;Enum "SSD Quality Status")
        {
            Caption = 'Status';
        }
        field(70; Posted; Boolean)
        {
            Caption = 'Posted';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Key1; Posted)
        {
        }
    }
}
