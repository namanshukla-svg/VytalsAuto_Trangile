tableextension 60015 "SSD ProductionBOM Line" extends "Production BOM Line"
{
    fields
    {
        field(60004; "SSD Consumption Station";Enum "SSD Production Station")
        {
            Caption = 'Consumption Station';
            DataClassification = CustomerContent;
        }
    }
}
