
CREATE TABLE public.bond_description_task
(
   "ISIN, RegCode, NRDCode" varchar(12),
	"FinToolType" text,
	"SecurityType" text,
	"SecurityKind" text,
	"CouponType" text,
	"RateTypeNameRus_NRD" text,
	"CouponTypeName_NRD" text,
	"HaveOffer" boolean,
	"AmortisedMty" boolean,
	"MaturityGroup" text,
	"IsConvertible" boolean,
	"ISINCode" varchar (12),
	"Status" text,
	"HaveDefault" boolean,
	"GuaranteeType" text,
	"GuaranteeAmount" text,
	"BorrowerName" text,
	"BorrowerOKPO" integer,
	"BorrowerSector" text,
	"BorrowerUID" integer,
	"IssuerName" text,
	"IssuerName_NRD" text,
	"IssuerOKPO" integer,
	"NumGuarantors" smallint,
	"EndMtyDate" date,
	CONSTRAINT bond_description_task_pkey PRIMARY KEY ("ISIN, RegCode, NRDCode")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;
