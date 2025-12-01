tableextension 60010 "SSD WarehouseShipment Line" extends "Warehouse Shipment Line"
{
    fields
    {
        field(60000; "SSD Dock No."; Code[20])
        {
            Caption = 'Dock No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60001; "SSD Slot No."; Code[20])
        {
            Caption = 'Slot No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60002; "SSD Slot Starting Time"; Time)
        {
            Caption = 'Slot Starting Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60003; "SSD Slot Ending Time"; Time)
        {
            Caption = 'Slot Ending Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60004; "SSD Material Type";Enum "SSD Item Sub Type")
        {
            Caption = 'Material Type';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60005; "Pick Planned"; Boolean)
        {
            Caption = 'Pick Planned';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}
