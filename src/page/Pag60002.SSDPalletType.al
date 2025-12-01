page 60002 "SSD Pallet Type"
{
    ApplicationArea = All;
    Caption = 'Pallet Type';
    PageType = List;
    SourceTable = "SSD Pallet Type";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }
}
