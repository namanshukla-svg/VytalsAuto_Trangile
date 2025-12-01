page 60006 "SSD Vehicles"
{
    ApplicationArea = All;
    Caption = 'Vehicles';
    PageType = List;
    SourceTable = "SSD Vehicle";
    CardPageId = "SSD Vehicle";
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
            }
        }
    }
}
