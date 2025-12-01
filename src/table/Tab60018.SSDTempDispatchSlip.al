table 60018 "SSD Temp Dispatch Slip"
{
    Caption = 'Temp dispatch slip Inv Pack Count';
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
        field(10; "Lot No"; code[50])
        {
            Caption = 'Lot No';
        }
        field(11; "Package No"; code[50])
        {
            Caption = 'Package No';
        }
    }
    keys
    {
        key(PK; "No.", "Item No.", Quantity, "Lot No")
        {
            Clustered = true;
        }
    }
}
