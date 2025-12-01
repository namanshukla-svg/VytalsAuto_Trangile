tableextension 60002 "SSD Item Auto" extends Item
{
    fields
    {
        field(60000; "SSD Item SubType"; Enum "SSD Item Sub Type")
        {
            Caption = 'Item SubType';
            DataClassification = CustomerContent;

            // trigger OnValidate()   //ANI::011225
            // begin
            //     if "SSD Item SubType" = "SSD Item SubType"::Bulk then TestField("SSD Pallet Type", '');
            // end;
        }
        field(60001; "SSD Low Flash"; Boolean)
        {
            Caption = 'Low Flash';
            DataClassification = CustomerContent;
        }
        // field(60002; "SSD Pallet Type"; Text[50]) //ANI::011225
        // {
        //     Caption = 'Pallet Type';
        //     DataClassification = CustomerContent;
        //     TableRelation = "SSD Pallet Type";

        //     trigger OnValidate()
        //     var
        //         ItemTypeErr: Label 'Pallet Type cannot be defined for Bulk Items';
        //     begin
        //         if("SSD Pallet Type" <> '') and ("SSD Item SubType" = "SSD Item SubType"::Bulk)then Error(ItemTypeErr);
        //     end;
        // }
        field(60004; "SSD Consumption Station"; Enum "SSD Production Station")
        {
            Caption = 'Consumption Station';
            DataClassification = CustomerContent;
        }
        field(60005; "SSD Packing"; Option)
        {
            OptionCaption = ' ,Pallet,Case,Master Carton,Inner Carton,Box,Roll,Steel Drum,PE Can,Bundles,Others,Plastic Drum';
            OptionMembers = " ",Pallet,"Case","Master Carton","Inner Carton",Box,Roll,"Steel Drum","PE Can",Bundles,Others,"Plastic Drum";
            DataClassification = CustomerContent;
            Caption = 'Packing';
        }
        field(60006; "SSD Storage Type"; Enum "SSD Storage Type")
        {
            Caption = 'Storage Type';
            DataClassification = CustomerContent;
        }
    }
}
