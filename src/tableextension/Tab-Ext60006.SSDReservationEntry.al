tableextension 60006 "SSD ReservationEntry" extends "Reservation Entry"
{
    fields
    {
        field(60000; "SSD Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DataClassification = CustomerContent;
        }
        field(60001; "SSD Entry Synced"; Boolean)
        {
            Caption = 'Entry Synced';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60002; "SSD Quality Required"; Boolean)
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
