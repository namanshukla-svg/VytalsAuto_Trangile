table 60011 "SSD Automation Setup"
{
    Caption = 'Automation Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
        }
        field(10; "Anzo User id"; Text[100])
        {
            Caption = 'Anzo User id';
        }
        field(11; "Anzo Password"; Text[100])
        {
            Caption = 'Anzo Password';
        }
        field(50; "Anzo Auth Url"; Text[100])
        {
            Caption = 'Anzo Auth Url';
        }
        field(100; "Anzo Receipt URL"; Text[100])
        {
            Caption = 'Anzo Receipt URL';
        }
        field(105; "Anzo Quality URL"; Text[100])
        {
            Caption = 'Anzo Quality URL';
        }
        field(110; "Anzo Pick Wave URL"; Text[100])
        {
            Caption = 'Anzo Pick Wave URL';
        }
        field(115; "Anzo Outward Shipment URL"; Text[100])
        {
            Caption = 'Anzo Outward Shipment URL';
        }
        field(120; "Anzo Production Pick URL"; Text[100])
        {
            Caption = 'Anzo Production Pick URL';
        }
        field(125; "Anzo Production Output URL"; Text[100])
        {
            Caption = 'Anzo Production Output URL';
        }
        field(130; "Anzo Prod. Consumption URL"; Text[100])
        {
            Caption = 'Anzo Production Consumption URL';
        }
        field(500; "Vehicle Nos."; Code[20])
        {
            Caption = 'Vehicle No.';
            TableRelation = "No. Series";
        }
        field(510; "Driver Nos."; Code[20])
        {
            Caption = 'Driver No.';
            TableRelation = "No. Series";
        }
        field(1000; "Show Json"; Boolean)
        {
            Caption = 'Show Json';
        }
        field(2000; "Blending Station No."; Text[100])
        {
            Caption = 'Blending Station No.';
        }
        field(2001; "Filling Station No."; Text[100])
        {
            Caption = 'Filling Station No.';
        }
        field(2010; "Output Station No."; Text[100])
        {
            Caption = 'Output Station No.';
        }
        field(3000; "Max Sample Count"; Integer)
        {
            Caption = 'Max Sample Count';
            MinValue = 0;
            InitValue = 0;
            MaxValue = 6;
        }
        field(3001; "Block SO Deletion"; Boolean)
        {
            Caption = 'Block Sales Order Deletion';
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
