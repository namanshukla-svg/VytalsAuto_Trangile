pageextension 60022 "SSD ProdOrder Components" extends "Prod. Order Components"
{
    layout
    {
        addlast(Control1)
        {
            field("SSD Consumption Station"; Rec."SSD Consumption Station")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Consumption Station field.', Comment = '%';
            }
            field("SSD WMS Request Sent"; Rec."SSD WMS Request Sent")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the WMS Request Sent field.', Comment = '%';
            }
        }
    }
    actions
    {
        addlast("F&unctions")
        {
            action(GetBlendingComponents)
            {
                ApplicationArea = All;
                Caption = 'Get Blending Components';
                Image = ActivateDiscounts;
                ToolTip = 'Executes the Get Blending Components action.';

                trigger OnAction()
                begin
                    Clear(SSDSyncProduction);
                    SSDSyncProduction.GetBlendingComponents(Rec);
                end;
            }
            action(GetFillingComponents)
            {
                ApplicationArea = All;
                Caption = 'Get Filling Components';
                Image = ActivateDiscounts;
                ToolTip = 'Executes the Get Filling Components action.';

                trigger OnAction()
                begin
                    Clear(SSDSyncProduction);
                    SSDSyncProduction.GetFillingComponents(Rec);
                end;
            }
        }
        addlast(Category_Process)
        {
            actionref(GetBlendingComponents_Promoted; GetBlendingComponents)
            {
            }
            actionref(GetFillingComponents_Promoted; GetFillingComponents)
            {
            }
        }
    }
    var SSDSyncProduction: Codeunit "SSD Sync Production Actions";
}
