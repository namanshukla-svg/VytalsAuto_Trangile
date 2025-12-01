codeunit 60005 "SSD Common Function Automation"
{
    procedure ItemPackageTracked(ItemNo: Code[20]): Boolean var
        ItemRec: Record Item;
        ItemTrackingCode3: Record "Item Tracking Code";
    begin
        ItemRec.SetLoadFields("No.", "Item Tracking Code");
        if not ItemRec.Get(ItemNo)then exit(false);
        if ItemRec."Item Tracking Code" = '' then exit(false);
        ItemTrackingCode3.SetLoadFields("Package Specific Tracking");
        if ItemTrackingCode3.Get(ItemRec."Item Tracking Code")then if ItemTrackingCode3."Package Specific Tracking" then exit(true)
            else
                exit(false);
        exit(false);
    end;
    procedure IsAutoPackageId(TrackingSpecification: Record "Tracking Specification"): Boolean begin
        if(TrackingSpecification."Source Type" = Database::"Purchase Line") and (TrackingSpecification."Source Subtype" = 1)then exit(true);
        exit(false);
    end;
    procedure IsLocationAutomated(LocationCode: Code[10]): Boolean var
        Location: Record Location;
    begin
        if Location.Get(LocationCode)then if Location."SSD Automated Plant" then exit(true);
        exit(false);
    end;
    procedure IsItemBulk(ItemNo: Code[20]): Boolean var
        Item: Record Item;
    begin
        if Item.Get(ItemNo)then if Item."SSD Item SubType" = Item."SSD Item SubType"::Bulk then exit(true);
        exit(false);
    end;
    procedure IsItemNonBulk(ItemNo: Code[20]): Boolean var
        Item: Record Item;
    begin
        if Item.Get(ItemNo)then if Item."SSD Item SubType" = Item."SSD Item SubType"::"Non-Bulk" then exit(true);
        exit(false);
    end;
    procedure GetDefaultLocation(): Code[10]var
        WarehouseEmployee: Record "Warehouse Employee";
        DefaultLocationErr: Label 'Default location is not defined for user %1', Comment = '%1 = User';
    begin
        if UserId() <> '' then begin
            WarehouseEmployee.SetCurrentKey(Default);
            WarehouseEmployee.SetRange(Default, true);
            WarehouseEmployee.SetRange("User ID", UserId());
            if WarehouseEmployee.IsEmpty()then Error(DefaultLocationErr, UserId);
            WarehouseEmployee.FindFirst();
            exit(WarehouseEmployee."Location Code");
        end;
    end;
    procedure GetAutomationLocationFilter()AutomatedLocationFilter: Text var
        Location: Record Location;
    begin
        AutomatedLocationFilter:='';
        Location.SetRange("SSD Automated Plant", true);
        if Location.FindSet()then repeat if AutomatedLocationFilter = '' then AutomatedLocationFilter:=Location.Code
                else
                    AutomatedLocationFilter+='|' + Location.Code;
            until Location.Next() = 0;
    end;
}
