tableextension 60145 GateEntryLine extends "Gate Entry Line"
{
    fields
    {
        // Add changes to table fields here
        field(50501; "Planning No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
    // Add changes to keys here
    }
    fieldgroups
    {
    // Add changes to field groups here
    }
    var myInt: Integer;
}
