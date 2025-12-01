table 60008 "SSD Warehouse Document Buffer"
{
    Caption = 'Warehouse Document Buffer';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Source Document";Enum "Warehouse Activity Source Document")
        {
            Caption = 'Source Document';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
    }
    keys
    {
        key(PK; "Source Document", "Document No.")
        {
            Clustered = true;
        }
    }
}
