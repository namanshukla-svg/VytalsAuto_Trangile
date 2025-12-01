table 60002 "SSD ASRS Zone"
{
    Caption = 'ASRS Zone';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(20; "Type";Enum "SSD Storage Type")
        {
            Caption = 'Type';
        }
    }
    keys
    {
        key(PK; "Location Code", "Code")
        {
            Clustered = true;
        }
    }
}
