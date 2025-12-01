tableextension 60005 "SSD TrackingSpecification" extends "Tracking Specification"
{
    fields
    {
        modify("Quantity (Base)")
        {
        trigger OnAfterValidate()
        var
            Item: Record Item;
        begin
            if "Item No." <> '' then begin
                Item.Get("Item No.");
                Validate("SSD Gross Weight", "Quantity (Base)" * Item."Gross Weight");
            //if Format(Item."Expiration Calculation") <> '' then
            //Validate("Expiration Date", CalcDate(Item."Expiration Calculation", Today));
            end;
        end;
        }
        field(60000; "SSD Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DataClassification = CustomerContent;
        }
        field(60001; "SSD Entry Synced"; Boolean)
        {
            Caption = 'Entry Synced';
            DataClassification = CustomerContent;
        //Editable = false;
        }
        field(60002; "SSD Quality Required"; Boolean)
        {
            Caption = 'Quality Required';
            DataClassification = CustomerContent;
        }
        field(62005; "SSD Vehicle Loaded"; Boolean)
        {
            Caption = 'Vehicle Loaded';
            DataClassification = CustomerContent;
        }
    }
}
