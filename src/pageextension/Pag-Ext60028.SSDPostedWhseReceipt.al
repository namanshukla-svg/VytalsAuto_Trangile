pageextension 60028 "SSD_Posted Whse. Receipt" extends "Posted Whse. Receipt"
{
    layout
    {
        addafter("Vendor No.")
        {
            field("SSD Source Name"; Rec."SSD Source Name")
            {
                ApplicationArea = All;
                Caption = 'Vendor Name';
                ToolTip = 'Specifies the value of the Source Name field.', Comment = '%';
                Visible = false;
            }
        }
    }
    actions
    {
        addbefore("Posted MRN Multi Lines")
        {
            action("Print Automation")
            {
                ApplicationArea = All;
                Caption = 'Print Automation';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Print;
                ToolTip = 'Executes the Print Automation action.';

                trigger OnAction()
                var
                    PostedWhseRcpt: Record "Posted Whse. Receipt Header";
                begin
                    PostedWhseRcpt.SetRange("No.", Rec."No.");
                    report.RunModal(Report::"SSD Posted MRN Automation", true, true, PostedWhseRcpt);
                end;
            }
            action("Print Automation For Multi-Document")
            {
                ApplicationArea = All;
                Caption = 'Print Automation For Multi-Document';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Print;
                ToolTip = 'Executes the Print Automation action.';

                trigger OnAction()
                var
                    PostedWhseRcpt: Record "Posted Whse. Receipt Header";
                    ModifiedVendorShipmentNo: Text;
                begin
                    Clear(ModifiedVendorShipmentNo);
                    ModifiedVendorShipmentNo:='@' + Rec."Vendor Shipment No." + '*';
                    PostedWhseRcpt.SetFilter("Vendor Shipment No.", ModifiedVendorShipmentNo);
                    report.RunModal(Report::"SSD Posted MRN Automation IG", true, true, PostedWhseRcpt);
                end;
            }
        }
    }
}
