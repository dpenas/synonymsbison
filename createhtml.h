#include <stdio.h>
void createhtml(FILE* file){
	printf("HOLAAA\n");
	char* beginhtml = "<!DOCTYPE html><html><head><body><title>Salida</title><style type=";
	char* beginhtml1 = "text/css";
	char* beginhtml2 = ">";
	char* beginhtml3 = "html,body {font-family: arial, verdana, sans-serif; font-size: 12px; margin:0px; height:100%;}table.Rtbl {border: solid 1px white; line-height:16px; border-collapse:collapse;}div#Otbl {padding: 0px;}span.EsIPA { font-family:";
	char* beginhtml4 = "\"Lucida Sans Unicode\", \"Arial Unicode MS\", \"Lucida Grande\"; color: blue; font-size: 10pt; }";
	char* beginhtml5 = ".small1 {font-size: x-small}tr.even	{background-color: #e8e8ff;vertical-align: top}tr.odd	{background-color: white;vertical-align: top}tr.evenEx {background-color: #e8e8ff;vertical-align: top}tr.oddEx  {background-color: white;vertical-align: top}td.Head	{padding-left:0px; padding-right: 10px; font-weight: bold; font-size:13px; text-decoration:underline; line-height:30px}#si {width:90%;max-width:180px;}#dictselect {font-size:11px;width:130px;}#Rtbl2		{position:absolute; right: 0px; top:278px; width:400px; border: solid 1px black;}table.Rtbl2	{line-height:16px; border-collapse:collapse;}.FrW2		{padding-left:1px;font-weight: bold;}.To2		{text-indent: 50px;font-style: italic}.FrCN2, td.ToW22, td.POS2	{padding-left:1px;font-size:11px;}.ToCN2	{padding-left:20px; font-style: italic}.ToW2	{padding-left:5px; padding-right: 5px}.Ex2, td.ToEx2	{padding-left: 5px; padding-right:5px; color:SlateGray;}.FrEx2	{padding-left: 5px; padding-right:5px; color:#483D8B;}.ToNt2	{padding-left: 5px; padding-right:5px; color:red;}span.POS2	{padding-left:2px;}.POS2		{color:#524BD3; font-style: italic;}";
	char* beginhtml6 = "tr.evenExHide, tr.oddExHide {display:none}td.nums1	{font-weight:bold;color:#5E58C7; vertical-align:top;text-align:right}td.roman1	{font-weight:bold;color:#5E58C7; vertical-align:top;font-size:16px;}span.roman1	{font-weight:bold;color:#5E58C7; vertical-align:bottom;}span.b	{font-weight:bold;}span.i, .bl	{color:#003399;}span.r	{color:red;}span.ic	{font-style:italic;color:#003399;}span.supr1	{vertical-align:super;color:#003399;}span.ac	{font-variant:small-caps;color:red;font-weight:bold;}div.trans	{padding:0px}ol.entry li	{margin-top:5px;}ol {padding-left:13px;}.hm, .su, .hom, .APICE, .sup, .tab		{vertical-align: super; font-size:10px}.sub	{vertical-align: sub; font-size:8px}.hide 	{display:none}";
	char* beginhtml7 = ".abb, .cfrf, .con, .contr, .cvf, .divar, .ell, .ex, .exp, .exs, .fem, .fm, .frm, .hcvf, .dex,.hcw, .idx, .inf, .mex, .mod, .nh, .prv, .pvb, .pvbv, .sig, .var, .x, .xi, .xrru, .cw, .phw, .stxt, .cmp, .dex, .femv, .frmv, .vcp, .prvx, .idm, .cv, .cx,.ef, .fs, .lc, .le, .li, .lo, .lp, .ls, .lu, .lv, .sb, .sl, .sp, .v, .vs, .G, .G2, .VF, .CG, .lemma, .fordiv, .cv, .nv,.f, .h2, .rb, .rbi, .pg, .bp, .pvv 		{font-weight:bold; color:black}.adj, .advex, .fld, .gl, .i, .ind, .lev, .mx, .nb, .vbs, .nex, .qdef, .qenc, .qnb, .qsyn, .syn, .u, .vbx, .vix, .ctx, .collo, .ix, .xg,.ico, .cs, .fi, .a, .ei, .ri, .co, .cs, .C, .CO, .CB,UC	{font-style:italic}.hw,.vpr, .nw, .ihw, .bhw 		{font-weight:bold; text-decoration:underline}.GG 	{font-weight:bold; fontstyle:italic}div.id, div.cpd 		{padding-left:0px; font-weight:bold}.reg, .fam, .coll, .la, .ide		{font-style:italic; fontweight: normal}.ps, .qps, .psv, .psyn, .ind, .pos, .gr, .infg, .u, .ei, .P, .indv, .old		{color:#003399; font-style:italic}.ul		{text-decoration: underline}.stln	{border-bottom: 1px solid black}.sc, .xs, .hl, .fx, .M, .fhl		{fontvariant: small-caps; text-transform:lowercase}.xr		{font-variant: small-caps; font-style:normal;}.psec, .ol, .vsec, .lemma, .catgram, .artsem, .o, .divgr, .cb, .hg .ps, .fordiv, .base, .hbase		{display: block;}.fp, .para		{display: block;padding-top:10pt}";
	char* beginhtml8 = ".un, .divgr, .approfondimento, .cgl, .fun	 	{display: block; border: 1px solid black; padding:5px; background: white}.scw, .scvf, .hbhw, .ix, .cn, .bhwes, .base		{display: none}.infg br, .pp br, .infmorf br, .la br, .ei br		{display:none}ol 		{padding-left: 20px;margin:2px;margin-left:5px}.ph, .fonetica		{ font-family:\"Lucida Sans Unicode\", \"Arial Unicode MS\",\"Lucida Grande\"; color: #003399; font-size: 10pt; }.qreg	{font-family: arial narrow; }.xsdr	{font-family: times}#temp,.sg, .pg, .cpd, .ct, .ne, .eg		{display: block}.se1, .pvp {display: block; padding-left:20px} .OxAd {display: none;}</style></head>";
	char* beginhtml9 = "<div><p class='wrcopyright'><a name=""></a> <table class='WRD' onclick='redirectWR(event,\"WRenes\")'>";

	fprintf(file, "%s", beginhtml);
	fprintf(file, "%s", beginhtml1);
	fprintf(file, "%s", beginhtml2);
	fprintf(file, "%s", beginhtml3);
	fprintf(file, "%s", beginhtml4);
	fprintf(file, "%s", beginhtml5);
	fprintf(file, "%s", beginhtml6);
	fprintf(file, "%s", beginhtml7);
	fprintf(file, "%s", beginhtml8);
	fprintf(file, "%s", beginhtml9);
}
