pageextension 60019 "SSD Posted Ow Gate Entry List" extends "Posted Outward Gate Entry List"
{
    layout
    {
        addafter("No.")
        {
            field("SSD Gate Out DateTime"; Rec."SSD Gate Out DateTime")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Posting Time"; Rec."Posting Time")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }
    trigger OnOpenPage()
    var
        PostedGateOutWardLine: Record "Posted Gate Entry Line";
        PostedSalesShipmentHdr: Record "Sales Shipment Header";
        PostedSalesInvHdr: Record "Sales Invoice Header";
        OrderNo: Code[20];
    begin
        PostedGateOutWardLine.Reset();
        PostedGateOutWardLine.SetRange("Entry Type", PostedGateOutWardLine."Entry Type"::Outward);
        PostedGateOutWardLine.SetRange("Sales Invoice No.", '');
        PostedGateOutWardLine.SetFilter("Source No.", '<>%1', '');
        if PostedGateOutWardLine.FindFirst()then repeat PostedSalesShipmentHdr.Reset();
                PostedSalesShipmentHdr.SetRange("Order No.", PostedGateOutWardLine."Source No.");
                if PostedSalesShipmentHdr.FindFirst()then begin
                    //     OrderNo := GetOrderCodeFromPostingDesc(PostedSalesShipmentHdr."Posting Description");
                    // if OrderNo <> '' then begin
                    PostedSalesInvHdr.Reset();
                    PostedSalesInvHdr.SetRange("Order/Scd. No.", PostedSalesShipmentHdr."Order No.");
                    if PostedSalesInvHdr.FindFirst()then begin
                        PostedGateOutWardLine."Sales Invoice No.":=PostedSalesInvHdr."No.";
                        PostedGateOutWardLine.Modify(true);
                    end;
                end;
            until PostedGateOutWardLine.Next() = 0;
    end;
    var local procedure GetOrderCodeFromPostingDesc(PostingDescription: Text[250]): Text[50]var
        StartPos: Integer;
        OrderCode: Text[50];
    begin
        if StrPos(PostingDescription, 'Order') > 0 then begin
            // Position after "Order " (with space)
            StartPos:=StrPos(PostingDescription, 'Order') + 6;
            OrderCode:=CopyStr(PostingDescription, StartPos, 50);
            exit(DelChr(OrderCode, '<>', ' ')); // remove leading/trailing spaces only
        end;
        exit('');
    end;
}
