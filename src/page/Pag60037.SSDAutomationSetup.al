page 60037 "SSD Automation Setup"
{
    ApplicationArea = All;
    Caption = 'Automation Setup';
    PageType = Card;
    SourceTable = "SSD Automation Setup";
    UsageCategory = Administration;
    Permissions = tabledata "Warehouse Entry"=m,
        tabledata "Item Ledger Entry"=m;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Anzo User id"; Rec."Anzo User id")
                {
                    ToolTip = 'Specifies the value of the Anzo User id field.', Comment = '%';
                }
                field("Anzo Password"; Rec."Anzo Password")
                {
                    ToolTip = 'Specifies the value of the Anzo Password field.', Comment = '%';
                }
                field("Show Json"; Rec."Show Json")
                {
                    ToolTip = 'Specifies the value of the Show Json field.', Comment = '%';
                }
                field("Block SO Deletion"; Rec."Block SO Deletion")
                {
                    ToolTip = 'Specifies the value of the Block Sales Order Deletion field.', Comment = '%';
                }
                field("Blending Station No."; Rec."Blending Station No.")
                {
                    ToolTip = 'Specifies the value of the Blending Station No. field.', Comment = '%';
                }
                field("Filling Station No."; Rec."Filling Station No.")
                {
                    ToolTip = 'Specifies the value of the Filling Station No. field.', Comment = '%';
                }
                field("Output Station No."; Rec."Output Station No.")
                {
                    ToolTip = 'Specifies the value of the Output Station Name field.', Comment = '%';
                }
            }
            group(Links)
            {
                Caption = 'Links';

                field("Anzo Auth Url"; Rec."Anzo Auth Url")
                {
                    ToolTip = 'Specifies the value of the Anzo Auth Url field.', Comment = '%';
                }
                field("Anzo Receipt URL"; Rec."Anzo Receipt URL")
                {
                    ToolTip = 'Specifies the value of the Anzo Receipt URL field.', Comment = '%';
                }
                field("Anzo Quality URL"; Rec."Anzo Quality URL")
                {
                    ToolTip = 'Specifies the value of the Anzo Quality URL field.', Comment = '%';
                }
                field("Anzo Pick Wave URL"; Rec."Anzo Pick Wave URL")
                {
                    ToolTip = 'Specifies the value of the Anzo Pick Wave URL field.', Comment = '%';
                }
                field("Anzo Sales Shipment URL"; Rec."Anzo Outward Shipment URL")
                {
                    ToolTip = 'Specifies the value of the Anzo Sales Shipment URL field.', Comment = '%';
                }
                field("Anzo Production Pick URL"; Rec."Anzo Production Pick URL")
                {
                    ToolTip = 'Specifies the value of the Anzo Production Pick URL field.', Comment = '%';
                }
                field("Anzo Production Output URL"; Rec."Anzo Production Output URL")
                {
                    ToolTip = 'Specifies the value of the Anzo Production Output URL field.', Comment = '%';
                }
                field("Anzo Prod. Consumption URL"; Rec."Anzo Prod. Consumption URL")
                {
                    ToolTip = 'Specifies the value of the Anzo Production Consumption URL field.', Comment = '%';
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';

                field("Vehicle Nos."; Rec."Vehicle Nos.")
                {
                    ToolTip = 'Specifies the value of the Vehicle No. field.', Comment = '%';
                }
                field("Driver Nos."; Rec."Driver Nos.")
                {
                    ToolTip = 'Specifies the value of the Driver No. field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(TestConnection)
            {
                ApplicationArea = All;
                Image = TestDatabase;
                Caption = 'Test Connection';
                ToolTip = 'Executes the Test Connection action.';

                trigger OnAction()
                var
                    SSDAutomationSyncMgt: Codeunit "SSD Automation Sync Mgt.";
                    ConnectionUnsuccessfulMsg: Label 'Test Connection Unsuccessful';
                    ConnectSuccessfulMsg: Label 'Test Connection Successful';
                begin
                    if SSDAutomationSyncMgt.TestConnection()then Message(ConnectSuccessfulMsg)
                    else
                        Message(ConnectionUnsuccessfulMsg);
                end;
            }
            action(UpdateSalesInvoice)
            {
                ApplicationArea = All;
                Image = UpdateDescription;
                Caption = 'Update Sales Invoice';
                ToolTip = 'Executes the Sales Invoice action.';

                trigger OnAction()
                var
                    SSDShipmentSubscribers: Codeunit "SSD Shipment Subscribers";
                begin
                    SSDShipmentSubscribers.UpdateSalesInvoiceLineWeight();
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        if not Rec.Get()then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
