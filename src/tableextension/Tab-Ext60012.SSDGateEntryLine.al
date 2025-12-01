tableextension 60012 "SSD Gate Entry Line" extends "Gate Entry Line"
{
    fields
    {
        modify("Source No.")
        {
        trigger OnAfterValidate()
        var
            PurchaseHeader: Record "Purchase Header";
            SalesHeader: Record "Sales Header";
            TransferHeader: Record "Transfer Header";
        begin
            case "Source Type" of "Source Type"::"Sales Order": begin
                SalesHeader.Get(SalesHeader."Document Type"::Order, "Source No.");
                "Source Name":=CopyStr(SalesHeader."Sell-to Customer Name", 1, MaxStrLen("Source Name"));
            end;
            "Source Type"::"Purchase Return Order": begin
                PurchaseHeader.Get(PurchaseHeader."Document Type"::"Return Order", "Source No.");
                "Source Name":=CopyStr(PurchaseHeader."Buy-from Vendor Name", 1, MaxStrLen("Source Name"));
            end;
            "Source Type"::"Outbound Transfer": begin
                TransferHeader.Get("Source No.");
                "Source Name":=CopyStr(TransferHeader."Transfer-to Name", 1, MaxStrLen("Source Name"));
            end;
            end;
        end;
        }
    }
}
