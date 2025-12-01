tableextension 60008 "SSD Item Ldg Entry" extends "Item Ledger Entry"
{
    fields
    {
        field(62000; "SSD Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DataClassification = CustomerContent;
        }
        field(62001; "SSD Entry Synced"; Boolean)
        {
            Caption = 'Entry Synced';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(62002; "SSD Quality Status";Enum "SSD Quality Status")
        {
            Caption = 'Quality Status';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(62003; "SSD Quality Posted"; Boolean)
        {
            Caption = 'Quality Posted';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(62004; "SSD Quality Required"; Boolean)
        {
            Caption = 'Quality Required';
            DataClassification = CustomerContent;
        }
        field(62005; "SSD Vehicle Loaded"; Boolean)
        {
            Caption = 'Vehicle Loaded';
            DataClassification = CustomerContent;
        }
    }
}
