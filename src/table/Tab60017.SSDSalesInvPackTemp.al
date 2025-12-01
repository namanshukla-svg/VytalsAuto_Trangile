table 60017 "SSD Sales Inv Pack Temp"
{
    Caption = 'Temp Sales Inv Pack Count';
    DataClassification = ToBeClassified;

    fields
    {
        field(5; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(6; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(8; "Package Count"; Integer)
        {
            Caption = 'Package Count';
        }
        field(9; "Pack Size"; Integer)
        {
            Caption = 'Pack Size';
        }
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
    }
    keys
    {
        key(PK; "No.", "Item No.", Quantity, "Line No.")
        {
            Clustered = true;
        }
    }
}
