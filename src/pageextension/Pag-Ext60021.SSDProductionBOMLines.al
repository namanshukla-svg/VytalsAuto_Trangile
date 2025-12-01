pageextension 60021 "SSD Production BOM Lines" extends "Production BOM Lines"
{
    layout
    {
        addafter("Routing Link Code")
        {
            field("SSD Consumption Station"; Rec."SSD Consumption Station")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Consumption Station field.', Comment = '%';
            }
        }
    }
}
