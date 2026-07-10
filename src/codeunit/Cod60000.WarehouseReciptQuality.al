codeunit 60026 "Warehouse Receipt Quality"
{
    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", OnPostSourceDocumentOnBeforePostPurchaseHeader, '', false, false)]
    local procedure OnPostSourceDocumentOnBeforePostPurchaseHeader(var PurchHeader: Record "Purchase Header"; WhseRcptHeader: Record "Warehouse Receipt Header"; SuppressCommit: Boolean; var CounterSourceDocOK: Integer; var IsHandled: Boolean)
    begin
        CreateQualityOrder(WhseRcptHeader);
    end;

    local procedure CreateQualityOrder(var WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    var
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        SourceTypeLocal: Option Purchase,Manufacturing,Routing,MRN;
        TemplateTypeLocal: Option Receipt,Manufacturing,Routing;
        QualityManagement: Codeunit "Quality Management";
        SetupQuality: Record "SSD Quality Setup";
        ItemLocal: Record Item;
        ReservationEntry: Record "Reservation Entry";
        ItemTrackingExist: Boolean;
        Item: Record Item;
        Location: Record Location;
        ItemPhyBinDetails: Record "SSD Item Phy. Bin Details";
        UserMgt: Codeunit "SSD User Setup Management";
        Lines: Integer;
        LocalIsHandled: Boolean;

        Text002: Label '%1 Nos. of Quality Order Generated ';
        Text003: Label 'Activate Quality Control Man. must be TRUE in Quality Setup ';
        TXT0006: Label 'Warehouse Recipt is Blocked.';
        Text0008: Label 'Item tracking lines are not defined for item no. %1.';
    begin
        OnBeforeCreateQualityOrder(WarehouseReceiptHeader, LocalIsHandled);

        if LocalIsHandled then
            exit;

        if WarehouseReceiptHeader.Blocked then
            Error(TXT0006);

        if not SetupQuality.Get(UserMgt.GetRespCenterFilter()) then begin
            SetupQuality.Init();
            SetupQuality."Responsibility Center" := UserMgt.GetRespCenterFilter();
        end;

        if not SetupQuality."Activate Quality Control Man." then
            Error(Text003);

        if Location.Get(WarehouseReceiptHeader."Location Code") then;

        Lines := 0;

        WarehouseReceiptLine.Reset();
        WarehouseReceiptLine.SetRange("No.", WarehouseReceiptHeader."No.");
        WarehouseReceiptLine.SetRange("Quality Required", true);
        WarehouseReceiptLine.SetRange("Send For Quality", false);
        WarehouseReceiptLine.SetFilter("Actual Qty. to Receive", '<>%1', 0);

        if WarehouseReceiptLine.FindSet() then
            repeat
                if Item.Get(WarehouseReceiptLine."Item No.") then;

                if Location."Phy. Bin Required" and Item."Phy. Bin Required" then begin
                    ItemPhyBinDetails.Reset();
                    ItemPhyBinDetails.SetRange("Document No.", WarehouseReceiptLine."No.");
                    ItemPhyBinDetails.SetRange("Document Line No.", WarehouseReceiptLine."Line No.");

                    if not ItemPhyBinDetails.FindFirst() then
                        Error('Please fill Item Phy. Bin Details')
                    else begin
                        ItemPhyBinDetails."Posting Date" := WarehouseReceiptHeader."Posting Date";
                        ItemPhyBinDetails.Modify();
                    end;
                end;

                ItemTrackingExist := true;
                ItemLocal.Get(WarehouseReceiptLine."Item No.");

                if ItemLocal."Item Tracking Code" <> '' then begin
                    ReservationEntry.Reset();
                    ReservationEntry.SetCurrentKey("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Reservation Status", "Shipment Date", "Expected Receipt Date");
                    ReservationEntry.SetRange("Source Type", WarehouseReceiptLine."Source Type");
                    ReservationEntry.SetRange("Source Subtype", WarehouseReceiptLine."Source Subtype");
                    ReservationEntry.SetRange("Source ID", WarehouseReceiptLine."Source No.");
                    ReservationEntry.SetRange("Source Ref. No.", WarehouseReceiptLine."Source Line No.");
                    ReservationEntry.SetFilter("Item Tracking", '%1|%2|%3|%4', ReservationEntry."Item Tracking"::"Lot No.", ReservationEntry."Item Tracking"::"Lot and Package No.", ReservationEntry."Item Tracking"::"Lot and Serial and Package No.", ReservationEntry."Item Tracking"::"Lot and Serial No.");
                    if not ReservationEntry.FindFirst() then begin
                        ItemTrackingExist := false;
                        Error(Text0008, WarehouseReceiptLine."Item No.");
                    end;
                end;
                if ItemTrackingExist then begin
                    QualityManagement.CreateReceiptQualityOrder(SourceTypeLocal::Purchase, WarehouseReceiptLine, TemplateTypeLocal::Receipt);
                    Lines += 1;
                end;
            until WarehouseReceiptLine.Next() = 0;
        WarehouseReceiptHeader."Create DateTime" := CurrentDateTime();
        WarehouseReceiptHeader.Modify();
        Message(Text002, Lines);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCreateQualityOrder(var WarehouseReceiptHeader: Record "Warehouse Receipt Header"; var IsHandled: Boolean)
    begin
    end;
}