page 60040 "SSD Quality Samples"
{
    ApplicationArea = All;
    Caption = 'Quality Samples';
    PageType = List;
    SourceTable = "SSD Quality Samples";
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.', Comment = '%';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies the value of the Lot No. field.', Comment = '%';
                }
                field("Package No."; Rec."Package No.")
                {
                    ToolTip = 'Specifies the value of the Package No. field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
                field("Qty (Base)"; Rec."Qty (Base)")
                {
                    ToolTip = 'Specifies the value of the Qty. (Base) field.', Comment = '%';
                }
                field("Quality Sample"; Rec."Quality Sample")
                {
                    ToolTip = 'Specifies the value of the Quality Sample field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            Group(Samples)
            {
                Caption = 'Samples';

                action(SelectSample)
                {
                    Caption = 'Select Sample';
                    Image = Select;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Select Sample action.';

                    trigger OnAction()
                    begin
                        Rec.SelectSample();
                    end;
                }
                action(RemoveSample)
                {
                    Caption = 'Remove Sample';
                    Image = Select;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Remove Sample action.';

                    trigger OnAction()
                    begin
                        Rec.DeselectSample();
                    end;
                }
            }
        }
        area(Promoted)
        {
            actionref(SelectSample_Promoted; SelectSample)
            {
            }
            actionref(RemoveSample_Promoted; RemoveSample)
            {
            }
        }
    }
}
