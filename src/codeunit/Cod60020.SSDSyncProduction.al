codeunit 60020 "SSD Sync Production"
{
    Permissions = tabledata "Item Ledger Entry"=rm;

    trigger OnRun()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemLedgerEntry2: Record "Item Ledger Entry";
        SSDProcessProdConsumption: Codeunit "SSD Process Prod Consumption";
        SSDProcessProdOutput: Codeunit "SSD Process Prod Output";
    begin
        ItemLedgerEntry.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Lot No.", "Serial No.", "Package No.");
        ItemLedgerEntry.SetRange("Location Code", SSDCommonFunctionAutomation.GetAutomationLocationFilter());
        ItemLedgerEntry.SetRange("SSD Entry Synced", false);
        ItemLedgerEntry.SetRange(Positive, true);
        ItemLedgerEntry.SetFilter("Package No.", '<>%1', '');
        ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Output);
        if ItemLedgerEntry.FindSet()then repeat Clear(SSDProcessProdOutput);
                if SSDProcessProdOutput.Run(ItemLedgerEntry)then begin
                    ItemLedgerEntry.SetLoadFields("Entry No.", "SSD Entry Synced");
                    ItemLedgerEntry2.Get(ItemLedgerEntry."Entry No.");
                    ItemLedgerEntry2."SSD Entry Synced":=true;
                    ItemLedgerEntry.Modify();
                    Commit();
                end;
            until ItemLedgerEntry.Next() = 0;
        ItemLedgerEntry.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Lot No.", "Serial No.", "Package No.");
        ItemLedgerEntry.SetRange("Location Code", SSDCommonFunctionAutomation.GetAutomationLocationFilter());
        ItemLedgerEntry.SetRange("SSD Entry Synced", false);
        ItemLedgerEntry.SetRange(Positive, false);
        ItemLedgerEntry.SetFilter("Package No.", '<>%1', '');
        ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
        if ItemLedgerEntry.FindSet()then repeat Clear(SSDProcessProdConsumption);
                if SSDProcessProdConsumption.Run(ItemLedgerEntry)then begin
                    ItemLedgerEntry.SetLoadFields("Entry No.", "SSD Entry Synced");
                    ItemLedgerEntry2.Get(ItemLedgerEntry."Entry No.");
                    ItemLedgerEntry2."SSD Entry Synced":=true;
                    ItemLedgerEntry.Modify();
                    Commit();
                end;
            until ItemLedgerEntry.Next() = 0;
    end;
    procedure SyncProductionOrderOutput(ProdOrderLine: Record "Prod. Order Line"; ReservationEntry: Record "Reservation Entry"; var APIStatus: Boolean; ErrorText: Text)
    var
        AccessToken: Text;
        RequestBody: Text;
        ResponseText: Text;
    begin
        WarehouseSetup.Get();
        if WarehouseSetup."SSD Internal Instance" then begin
            APIStatus:=true;
            exit;
        end;
        ProdOrderLine.TestField("Location Code");
        if not SSDCommonFunctionAutomation.IsLocationAutomated(ProdOrderLine."Location Code")then exit;
        SSDAutomationSetup.Get();
        SSDAutomationSetup.TestField("Anzo Production Output URL");
        AccessToken:=SSDAutomationSyncMgt.GetAccessToken();
        Clear(SSDSyncProductionActions);
        RequestBody:=SSDSyncProductionActions.CreatePutAwayJson(ProdOrderLine, ReservationEntry);
        if SSDAutomationSetup."Show Json" then Message(RequestBody);
        Clear(SSDAutomationSyncMgt);
        ResponseText:=SSDAutomationSyncMgt.PostAnzo(SSDAutomationSetup."Anzo Production Output URL", RequestBody, AccessToken);
    //No Response Text is received from Anzo
    // JsonToken.ReadFrom(ResponseText);
    // Clear(JsonObject);
    // JsonObject := JsonToken.AsObject();
    // ResponseText := GetJsonToken(JsonObject, 'status').AsValue().AsText();
    // if ResponseText = 'Success' then begin
    //     APIStatus := true;
    //     ErrorText := '';
    // end else
    //     Error(ResponseText);
    end;
    // local procedure GetJsonToken(JsonObject: JsonObject; TokenKey: text) JsonToken: JsonToken;
    // begin
    //     if not JsonObject.Get(TokenKey, JsonToken) then
    //         Error('Could not find a token with key %1', TokenKey);
    // end;
    var SSDAutomationSetup: Record "SSD Automation Setup";
    WarehouseSetup: Record "Warehouse Setup";
    SSDAutomationSyncMgt: Codeunit "SSD Automation Sync Mgt.";
    SSDCommonFunctionAutomation: Codeunit "SSD Common Function Automation";
    SSDSyncProductionActions: Codeunit "SSD Sync Production Actions";
}
