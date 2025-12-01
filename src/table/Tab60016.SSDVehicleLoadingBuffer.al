table 60016 "SSD Vehicle Loading Buffer"
{
    Caption = 'Vehicle Loading Buffer';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(5; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(10; "Dock No."; Code[20])
        {
            Caption = 'Dock No.';
        }
        field(20; "Shipment No."; Code[20])
        {
            Caption = 'Shipment No.';
        }
        field(25; "Shipment Line No."; Integer)
        {
            Caption = 'Shipment Line No.';
        }
        field(30; "Reservation Entry No."; Integer)
        {
            Caption = 'Reservation Entry No.';
        }
        field(200; "Package No."; Code[50])
        {
            Caption = 'Package No.';
        }
        field(210; "Vehicle Loaded"; Boolean)
        {
            Caption = 'Vehicle Loaded';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Key1; "Vehicle Loaded", "Package No.", "Shipment No.", "Location Code", "Dock No.")
        {
        }
    }
}
