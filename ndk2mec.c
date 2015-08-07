//  junlysky.info@gmail.com
# include <stdio.h>
# include <stdlib.h>
# include <string.h>
# include <math.h>

enum hang { one, two, three, four, five };

int main(int argc,char **argv){
    FILE *fpin;
    FILE *fpout;
    
    if(argc<=2){
        printf("usage:ndk2mec infile outfile \n");
        return 0;
    }
    
    --argc;
    ++argv;
    fpin=fopen(*argv,"r");
    if(fpin == NULL){
        printf("error to open %s.\n",*argv);
        return 0;
    }
    
    ++argv;
    fpout=fopen(*argv,"w");
    if(fpout==NULL){
        printf("error to build %s.\n",*argv);
        return 0;
    }

    char lines[512];
 
    char catlog[4],date[10],time[10],gloca[24];
    float lat,lon,dep,mag_mb,mag_ms;
    char name[16],cmt_para[64];
    char lin3[80];
    int exponent;
    float mrr,mtt,mpp,mrt,mrp,mtp; //r is up,t is south,p is east
    float err1,err2,err3,err4,err5,err6;
    char ver[3];
    float p_gen,p_plu,p_azi,b_gen,b_plu,b_azi,t_gen,t_plu,t_azi,scalar;
    float str1,dip1,rak1,str2,dip2,rak2;

    fprintf (fpout, "date time lon lat depth Mb Ms strike1 dip1  rake1  strike2  dip2  rake2   mrr  mtt  mpp  mrt  mrp  mtp  p_azi  p_plu  p_eigen  b_azi  b_plu  b_eigen  t_azi  t_plu  t_eigen  scale  exponent  name \n");

    int i=0;
    enum hang count; 
    while(fgets(lines,sizeof(lines),fpin)){
        count=i%5;
      
        if(count == 0){
            sscanf(lines,"%s %s %s %f %f %f %f %f %s ",catlog,date,time,&lat,&lon,&dep,&mag_mb,&mag_ms,gloca);
        }
        else if(count ==1){
            sscanf(lines,"%s %s",name,cmt_para);
        }
        else if(count ==2 ){
            sscanf(lines,"%s",lin3);
        }
        else if(count == 3){
            sscanf(lines,"%d %f %f %f %f %f %f %f %f %f %f %f %f",&exponent,&mrr,&err1,&mtt,&err2,&mpp,&err3,&mrt,&err4,&mrp,&err5,&mtp,&err6);
        }
        else if (count ==4){
            sscanf(lines,"%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f",ver,&p_gen,&p_plu,&p_azi,&b_gen,&b_plu,&b_azi,&t_gen,&t_plu,&t_azi,&scalar,&str1,&dip1,&rak1,&str2,&dip2,&rak2);
            fprintf(fpout,"%s %s %.2f %.2f %.1f %.1f %.1f %.0f %.0f %.0f %.0f %.0f %.0f %.3f %.3f %.3f %.3f %.3f %.3f %.1f %.1f %.3f %.1f %.1f %.3f %.1f %.1f %.3f %.3f %2d %s \n",date,time,lon,lat,dep,mag_mb,mag_ms,str1,dip1,rak1,str2,dip2,rak2,mrr,mtt,mpp,mrt,mrp,mtp,p_azi,p_plu,p_gen,b_azi,b_plu,b_gen,t_azi,t_plu,t_gen,scalar,exponent,name);
        }
        else {
             printf ("something is wrong! \n");
            return 0;
        }
        i++;
    }

    fclose(fpin);
    fclose(fpout);
    return 0;
}