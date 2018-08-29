#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#define infinity 32767
#define maxsize 50

typedef struct
{
    int stack[maxsize];
    int top;
}SeqStack;


typedef struct arcnode//邻接表结构体
{
    char routename[20];/*航线名*/
    int serialnum;/*下一站机场序号*/
    int timelength;/*飞行所需时长(分),这里把时间作为权重*/
    struct arcnode *next;
}anode;

typedef struct vertexnode
{
    int visit;/*访问标志*/
    int in;/*入度*/
    int out;/*出度*/
    char airportname[20];/*机场名称*/
    char safelevel[10];/*机场安全系数*/
    char narration[100];/*机场叙述*/
    anode *head;
}vnode;

typedef struct
{
    vnode vertex[maxsize];
    int portnum;/*机场数*/
    int airlinenum;/*航线数*/
}adjlist;



typedef struct
{
    int routes[maxsize][maxsize];
    int portnum;//机场数
    char airpotname[maxsize][100];//机场名称
}adjmartrix;



void establish(adjlist *a)//把创建的图写入文件，放到creategraph(adjlist *a)中
{
    int i,j;
    anode *p;
    
    FILE *sfp,*rfp;
    sfp=fopen("air.txt","wt");//创建新机场文件
    rfp=fopen("route.txt","wt");
    fprintf(sfp,"%d %d\n",a->portnum,a->airlinenum);/*机场数和航线数写到air中*/
    for(i=1;i<=a->portnum;i++)
        fprintf(sfp,"%s %s %s %d %d\n",a->vertex[i].airportname,a->vertex[i].safelevel,a->vertex[i].narration,a->vertex[i].out,a->vertex[i].in);
    for(i=1;i<=a->portnum;i++)/*航线信息写到route中*/
    {
        p=a->vertex[i].head;
        if(a->vertex[i].out!=0)
        {
            fprintf(rfp,"%s %d %d\n",p->routename,p->serialnum,p->timelength);
            p=p->next;
        }
        for(j=1;j<a->vertex[i].out;j++)
        {
            fprintf(rfp,"%s %d %d\n",p->routename,p->serialnum,p->timelength);
            p=p->next;
        }
    }
    fclose(sfp);//关闭文件
    fclose(rfp);//关闭文件
}




void churudu(adjlist *a)/*计算出度和入度*/
{
    int i,n;
    anode *p;
    for(i=1;i<=a->portnum;i++)/*计算出度*///问题
    {
        p=a->vertex[i].head;
        if(p!=NULL)
        {
            n=1;
            p=p->next;
        }
        else
            n=0;
        while(p!=NULL)
        {
            n++;
            p=p->next;
        }
        a->vertex[i].out=n;
    }
    for(i=1;i<=a->portnum;i++)
        a->vertex[i].in=0;/*在调用churudu()之前，原有机场入度变为0*/
    for(i=1;i<=a->portnum;i++)/*计算入度*/
    {
        p=a->vertex[i].head;
        while(p!=NULL)
        {
            a->vertex[p->serialnum].in=a->vertex[p->serialnum].in+1;/*入度自增1*/
            p=p->next;
        }
    }
}



void creategraph(adjlist *a)/*创建图*/
{
    int i,n,j;
    int flag=1;
    anode *p = NULL,*q;
    while(flag)
    {
        printf("请输入机场数，航线数:\n");
        printf("(默认所输入的第n个机场的序号为n)\n");
        scanf("%d %d",&a->portnum,&a->airlinenum);
        if(a->airlinenum > (a->portnum-1)*a->portnum/2||a->airlinenum==0)/*判断输入的机场数和航线数是否能构成一个图*/
            printf("输入有误，请重新输入:\n");
        else
            flag=0;
    }
    flag=1;
    getchar();
    for(i=1;i<=a->portnum;i++)/*输入机场*/
    {
        printf("请输入第%d个机场名称:\n",i);
        scanf("%s",a->vertex[i].airportname);
        printf("请输入该机场安全系数:\n");
        scanf("%s",a->vertex[i].safelevel);
        printf("请叙述机场:\n");
        scanf("%s",a->vertex[i].narration);
        a->vertex[i].head=NULL;/*头结点置空*/
        a->vertex[i].out=0;/*出度初始为0*/
    }
    for(i=1;i<=a->portnum;i++)/*输入下一站机场*/
    {
        getchar();
        printf("请输入剩余的%s的下一站机场个数:\n",a->vertex[i].airportname);
        scanf("%d",&n);
        if(n>0)
        {
            p=a->vertex[i].head;
            if(p==NULL)
            {
                p=a->vertex[i].head=(anode *)malloc(sizeof(anode));/*第一次要把邻接点和头结点链接*/
                while(flag)
                {
                    printf("请输入第1个下一站机场序号和航行时长:\n");
                    printf("(默认所输入的第n个机场的序号为n)\n");
                    scanf("%d %d",&p->serialnum,&p->timelength);
                    if(p->serialnum==i)
                        printf("输入有误，请重新输入\n");
                    else
                        flag=0;
                }
                flag=1;
                printf("请输入航线名:\n");
                scanf("%s",p->routename);
                p->next=NULL;
            }
            else
            {
                for(;p->next!=NULL;p=p->next)//如果头结点不为空，则p向后移动，防止在邻接表中相互指向时头结点被篡改
                {;}
                n=n+1;//因为下面的for只适用于if完成之后的操作，为了适应else完成之后的操作，需要n自增1
                flag=0;
            }
        }
        for(j=1;j<n;j++)
        {
            q=(anode *)malloc(sizeof(anode));
            q->next=NULL;
            p->next=q;
            p=q;
            if(flag==1)
                printf("请输入第%d个下一站机场序号和航行时长:\n",j+1);
            else
                printf("请输入第%d个下一站机场序号和航行时长:\n",j);
            scanf("%d %d",&p->serialnum,&p->timelength);
            printf("请输入航线名:\n");
            scanf("%s",p->routename);
        }
        for(p=a->vertex[i].head;p!=NULL;p=p->next)/*无向图在邻接表中相互指向*/
        {
            if(p->serialnum>i)
            {
                if(a->vertex[p->serialnum].head==NULL)
                    q=a->vertex[p->serialnum].head=(anode *)malloc(sizeof(anode));
                else
                {
                    for(q=a->vertex[p->serialnum].head;q->next!=NULL;)
                        q=q->next;
                    q->next=(anode *)malloc(sizeof(anode));
                    q=q->next;
                }
                q->next=NULL;
                q->serialnum=i;
                strcpy(q->routename,p->routename);
                q->timelength=p->timelength;
            }
        }
    }
    churudu(a);
    establish(a);
    printf("恭喜您创建完成!\n");
}



void readfile(adjlist *a,FILE *sfp,FILE *rfp)/*读文件*/
{
    int i,j;
    anode *p = NULL,*q;
    fscanf(sfp,"%d %d\n",&a->portnum,&a->airlinenum);/*先读出机场数*/
    for(i=1;i<=a->portnum;i++)/*读入机场*/
    {
        fscanf(sfp,"%s %s %s %d %d\n",a->vertex[i].airportname,a->vertex[i].safelevel,a->vertex[i].narration,&a->vertex[i].in,&a->vertex[i].out);
        a->vertex[i].head=NULL;/*头结点置空*/
    }
    for(i=1;i<=a->portnum;i++)/*读入下一站机场*/
    {
        if(a->vertex[i].out!=0)
        {
            a->vertex[i].head=p=(anode *)malloc(sizeof(anode));/*第一次先读出头结点信息*/
            fscanf(rfp,"%s %d %d",p->routename,&p->serialnum,&p->timelength);
            p->next=NULL;
        }
        for(j=1;j<a->vertex[i].out;j++)
        {
            q=(anode *)malloc(sizeof(anode));
            q->next=NULL;
            p->next=q;
            p=q;
            fscanf(rfp,"%s %d %d",p->routename,&p->serialnum,&p->timelength);
        }
    }
    
}



void show(adjlist *a)/*显示所有机场和航线信息，管理界面显示*/
{
    int i;
    anode *p;
    printf("序号  机场名称    机场安全系数   机场叙述\n");
    for(i=1;i<=a->portnum;i++)
        printf("%d      %s     %s     %s\n",i,a->vertex[i].airportname,a->vertex[i].safelevel,a->vertex[i].narration);
    if(a->airlinenum==0)
        printf("没有航线!\n");
    else
        printf("航线名称   航行时长(分)   起点序号   终点序号\n");
    for(i=1;i<=a->portnum;i++)
    {
        for(p=a->vertex[i].head;p!=NULL;p=p->next)
            if(i<p->serialnum)
                printf("%s    %d     %d    %d\n",p->routename,p->timelength,i,p->serialnum);
    }
}



void add(int s,adjlist *a)/*增加机场和航线*/
{
    
    int n,m,i,j,y,l,flag=1;
    anode *p = NULL,*q;
    char name[20];
    system("cls");
    show(a);
    if(s==4)
    {
        printf("请输入机场数和航线数:\n");
        scanf("%d %d",&n,&m);
        for(i=1;i<=n;i++)
        {
            printf("请输入第%d个新机场名称:\n",i);
            scanf("%s",a->vertex[a->portnum+i].airportname);
            printf("请输入第%d个新机场安全系数:\n",i);
            scanf("%s",a->vertex[a->portnum+i].safelevel);
            printf("请输入第%d个新机场叙述:\n",i);
            scanf("%s",a->vertex[a->portnum+i].narration);
            a->vertex[a->portnum+i].out=0;/*出度初始为0*/
        }
        for(i=1;i<=n;i++)/*输入新机场的下一站机场*/
        {
            getchar();
            printf("请输入%s的下一站机场个数:\n",a->vertex[a->portnum+i].airportname);
            scanf("%d",&y);
            if(y>0)
            {
                a->vertex[a->portnum+i].head=p=(anode *)malloc(sizeof(anode));/*第一次要把邻接点和头结点链接*/
                while(flag)
                {
                    printf("请输入第1个下一站机场序号和航行时长:\n");
                    scanf("%d %d",&p->serialnum,&p->timelength);
                    if(p->serialnum==a->portnum+i)
                        printf("输入有误，请重新输入:\n");
                    else
                        flag=0;
                }
                flag=1;
                printf("请输入航线名:\n");
                scanf("%s",p->routename);
                p->next=NULL;
            }
            for(j=1;j<y;j++)
            {
                q=(anode *)malloc(sizeof(anode));
                q->next=NULL;
                p->next=q;
                p=q;
                printf("请输入第%d个下一站机场序号和航行时长(分):\n",j+1);
                scanf("%d %d",&p->serialnum,&p->timelength);
                printf("请输入航线名:\n");
                scanf("%s",p->routename);
            }
        }
        for(i=1;i<=n;i++)/*建立原有机场与新加机场的联系*/
            for(p=a->vertex[a->portnum+i].head;p!=NULL;p=p->next)
            {
                if(a->vertex[p->serialnum].head==NULL)
                    q=a->vertex[p->serialnum].head=(anode *)malloc(sizeof(anode));
                else
                {
                    for(q=a->vertex[p->serialnum].head;q->next!=NULL;)
                        q=q->next;
                    q->next=(anode *)malloc(sizeof(anode));
                    q=q->next;
                }
                q->next=NULL;
                q->serialnum=a->portnum+i;
                strcpy(q->routename,p->routename);
                q->timelength=p->timelength;
            }
        a->portnum=a->portnum+n;/*增加机场后的机场数*/
        a->airlinenum=a->airlinenum+m;/*增加航线后的航线数*/
    }
    else
    {
        printf("请输入要增加新航线的数量:\n");
        scanf("%d",&y);
        a->airlinenum=a->airlinenum+y;
        for(i=1;i<=y;i++)
        {
            printf("请输入要增加新航线的起点和终点序号:\n");
            scanf("%d %d",&m,&n);
            if(a->vertex[m].head==NULL)/*对m机场端的航线信息*/
            {
                q=a->vertex[m].head=(anode *)malloc(sizeof(anode));
                q->next=NULL;
            }
            else
            {
                for(q=a->vertex[m].head;q->next!=NULL;)
                    q=q->next;
                q->next=(anode *)malloc(sizeof(anode));
                q=q->next;
                q->next=NULL;
            }
            q->serialnum=n;
            printf("请输入航线名:\n");
            scanf("%s",q->routename);
            strcpy(name,q->routename);/*中间变量*/
            printf("请输入第%d个新航线的航行时长:\n",i);
            scanf("%d",&q->timelength);
            l=q->timelength;
            if(a->vertex[n].head==NULL)/*对n机场端的航线信息，与m的相对应*/
            {
                q=a->vertex[n].head=(anode *)malloc(sizeof(anode));
                q->next=NULL;
            }
            else
            {
                for(q=a->vertex[n].head;q->next!=NULL;)
                    q=q->next;
                q->next=(anode *)malloc(sizeof(anode));
                q=q->next;
                q->next=NULL;
            }
            q->serialnum=m;
            strcpy(q->routename,name);
            q->timelength=l;
        }
    }
    churudu(a);
    establish(a);
    printf("恭喜您增添成功！\n");
    getchar();
    printf("按任意键返回上层...");
    getchar();
}



void modify(int s,adjlist *a)/*修改机场信息*/
{
    int n,i;
    FILE *sfp;
    show(a);
    printf("请输入要修改的机场的序号:\n");
    scanf("%d",&n);
    if(s==1)
    {
        printf("请输入机场新名称:\n");
        scanf("%s",a->vertex[n].airportname);
    }
    else if(s==2)
    {
        printf("请输入机场新安全系数:\n");
        scanf("%s",a->vertex[n].safelevel);
    }
    else
    {
        printf("请输入机场新叙述:\n");
        scanf("%s",a->vertex[n].narration);
    }
    sfp=fopen("air.txt","wt");//创建新机场文件
    fprintf(sfp,"%d %d\n",a->portnum,a->airlinenum);/*机场数和航线数写到air中*/
    for(i=1;i<=a->portnum;i++)
        fprintf(sfp,"%s %s %s %d %d\n",a->vertex[i].airportname,a->vertex[i].safelevel,a->vertex[i].narration,a->vertex[i].out,a->vertex[i].in);
    fclose(sfp);//关闭文件
    printf("恭喜您修改成功！\n");
    getchar();
    printf("按任意键返回上层...");
    getchar();
}



void modifyroute(int s,adjlist *a)/*修改航线信息*/
{
    int m,n,t = 0,i,j;
    char name[20];
    anode *p;
    FILE *rfp;
    show(a);
    printf("请输入要修改的起点和终点序号:\n");
    scanf("%d %d",&m,&n);
    for(p=a->vertex[m].head;p!=NULL;p=p->next)
    {
        if(p->serialnum==n)
        {
            if(s==6)
            {
                printf("请输入航线新名称:\n");
                scanf("%s",p->routename);
                strcpy(name,p->routename);
            }
            else
            {
                printf("请输入航线新的航行时长:\n");
                scanf("%d",&p->timelength);
                t=p->timelength;
            }
        }
    }
    for(p=a->vertex[n].head;p!=NULL;p=p->next)/*因为要存入文件且这是一个无向图，所以改了m和n也就得改n和m，这才能保证存入文件的信息是一致的,若为有向图则删掉该for*/
    {
        if(p->serialnum==m)
        {
            if(s==6)
                strcpy(p->routename,name);
            else
                p->timelength=t;
        }
    }
    rfp=fopen("route.txt","wt");
    for(i=1;i<=a->portnum;i++)/*航线信息写到route中*/
    {
        p=a->vertex[i].head;
        if(a->vertex[i].out>0)
        {
            
            fprintf(rfp,"%s %d %d\n",p->routename,p->serialnum,p->timelength);
            p=p->next;
        }
        for(j=1;j<a->vertex[i].out;j++)
        {
            fprintf(rfp,"%s %d %d\n",p->routename,p->serialnum,p->timelength);
            p=p->next;
        }
    }
    fclose(rfp);//关闭文件
    printf("恭喜您修改成功！\n");
    getchar();
    printf("按任意键返回上层...");
    getchar();
}



void del(int s,adjlist *a)/*删除机场和航线*/
{
    anode *p,*q;
    int n,m,i;
    show(a);
    if(s==5)
    {
        printf("请输入要删除的机场序号:\n");
        scanf("%d",&n);
        for(i=1;i<=a->portnum;)
        {
            if(i==n||a->vertex[i].head==NULL)
                i++;
            else
            {
                if(a->vertex[i].head->serialnum==n)/*先判断头结点是否需要删除*/
                {
                    q=a->vertex[i].head->next;
                    free(a->vertex[i].head);
                    a->airlinenum=a->airlinenum-1;
                    a->vertex[i].head=q;
                }
                else
                    for(p=a->vertex[i].head;p->next!=NULL;p=p->next)
                    {
                        q=p->next;
                        if(q->serialnum==n)
                        {
                            p->next=q->next;
                            free(q);
                            a->airlinenum=a->airlinenum-1;/*与机场相关的航线少了一条，总航线数当然要减1*/
                            break;
                        }
                    }
                i++;
            }
        }
        for(i=n;i<a->portnum;i++)/*删除机场后把该机场后的元素依次向前移动*/
            a->vertex[i]=a->vertex[i+1];
        a->portnum=a->portnum-1;/*总机场数减1*/
        for(i=1;i<=a->portnum;i++)
            for(p=a->vertex[i].head;p!=NULL;p=p->next)/*元素依次向前移动之后，原先存储的序号也要保持一致*/
                if(p->serialnum>n)
                    p->serialnum--;
    }
    else
    {
        printf("请输入要删除航线的起点和终点序号:\n");
        scanf("%d %d",&m,&n);
        if(a->vertex[m].head->serialnum==n)/*以m为起点的删除航线*/
        {
            q=a->vertex[m].head->next;
            free(a->vertex[m].head);
            a->airlinenum=a->airlinenum-1;/*与机场相关航线少了一条，总航线数当然要减1*/
            a->vertex[m].head=q;
        }
        else
            for(p=a->vertex[m].head;p->next!=NULL;p=p->next)
            {
                q=p->next;
                if(q->serialnum==n)
                {
                    p->next=q->next;
                    free(q);
                    a->airlinenum=a->airlinenum-1;/*与机场相关航线少了一条，总航线数当然要减1*/
                    break;
                }
            }
        if(a->vertex[n].head->serialnum==m)/*以m为起点的删除航线*/
        {
            q=a->vertex[n].head->next;
            free(a->vertex[n].head);
            a->vertex[n].head=q;
        }
        else
            for(p=a->vertex[n].head;p->next!=NULL;p=p->next)
            {
                q=p->next;
                if(q->serialnum==m)
                {
                    p->next=q->next;
                    free(q);
                    break;
                }
            }
    }
    churudu(a);
    establish(a);
    printf("恭喜您删除成功！\n");
    getchar();
    printf("按任意键返回上层...");
    getchar();
}
adjmartrix Exchange(adjlist *a)//邻接表转化为带权图邻接矩阵
{
    adjmartrix b;
    anode *p;
    int i,j;
    b.portnum=a->portnum;
    for(i=1;i<=a->portnum;i++)
    {
        strcpy(b.airpotname[i],a->vertex[i].airportname);
        for(j=1;j<=a->portnum;j++)
            b.routes[i][j]=infinity;//初始化为极大值
    }
    for(i=1;i<=a->portnum;i++)
        for(p=a->vertex[i].head;p!=NULL;p=p->next)
        {
            if(p==a->vertex[i].head)
                b.routes[i][p->serialnum]=p->timelength;
            else
                b.routes[i][p->serialnum]=p->timelength;
        }
    return b;
}



void Dijkstra(adjlist *a,adjmartrix *b,int start,int *dist,int (*path)[maxsize])//最短航线算法
{
    int mindist,i,j,k = 0,t=1;
    for(i=1;i<=a->portnum;i++)
    {
        dist[i]=b->routes[start][i];
        if(b->routes[start][i]!=infinity)
            path[i][1]=start;
    }
    path[start][0]=1;
    for(i=2;i<=a->portnum;i++)
    {
        mindist=infinity;
        for(j=1;j<=a->portnum;j++)
        {
            if(!path[j][0]&&dist[j]<mindist)
            {
                k=j;
                mindist=dist[j];
            }
        }
        if(mindist==infinity) return;
        path[k][0]=1;
        for(j=1;j<=a->portnum;j++)
        {
            if(!path[j][0]&&b->routes[k][j]<infinity&&dist[k]+b->routes[k][j]<dist[j])
            {
                dist[j]=dist[k]+b->routes[k][j];
                t=1;
                while(path[k][t]!=0)
                {
                    path[j][t]=path[k][t];
                    t++;
                }
                path[j][t]=k;
                path[j][t+1]=0;
            }
        }
    }
}



void bestvoyage(adjlist *a)//寻找最短航线
{
    
    int i,start = 0,j,flag=1;
    char name[20];
    int dist[maxsize];
    int path[maxsize][maxsize];
    adjmartrix b=Exchange(a);//把邻接表a转化为邻接矩阵b
    for(i=1;i<maxsize;i++)
    {
        dist[i]=infinity;
        for(j=0;j<maxsize;j++)
            path[i][j]=0;
    }
    printf("请输入起点名称:\n");
    scanf("%s",name);
    for(i=1;i<=a->portnum;i++)
    {
        if(strcmp(b.airpotname[i],name)==0)
        {start=i;
            flag=1;
            break;
        }
        flag=0;
    }
    if(flag==0)
    {
        printf("此机场不存在!");
        getchar();
        printf("按任意键返回上层...");
        getchar();
        return;
    }
    Dijkstra(a,&b,start,dist,path);
    printf("%s到其它机场的最短行程航线为:\n",a->vertex[start].airportname);
    for(i=1;i<=a->portnum;i++)
    {
        if(i!=start)
        {
            printf("%s",a->vertex[start].airportname);//显示最短航线
            for(j=2;j<a->portnum;j++)
            {
                if(path[i][j]!=0)
                    printf("---->%s",a->vertex[path[i][j]].airportname);
                else
                    printf("---->%s",a->vertex[i].airportname);
                if(path[i][j]==0)
                    break;
            }
        }
        if(i!=start)
            printf("\n");
    }
    getchar();
    printf("按任意键返回上层...");
    getchar();
}



void showall(adjlist *a)/*显示所有机场和航线信息，用户界面显示*/
{
    int i;
    anode *p;
    printf("机场名称              机场安全系数     机场叙述\n");
    for(i=1;i<=a->portnum;i++)
        printf("%-17s     %-8s     %s\n",a->vertex[i].airportname,a->vertex[i].safelevel,a->vertex[i].narration);
    printf("----------------------------------------------\n");
    printf("航线名称       航行时长(分)          起点              终点\n");
    for(i=1;i<=a->portnum;i++)
    {
        for(p=a->vertex[i].head;p!=NULL;p=p->next)
            if(i<p->serialnum)
                printf("%-11s    %-10d     %-16s    %s\n",p->routename,p->timelength,a->vertex[i].airportname,a->vertex[p->serialnum].airportname);
    }
    getchar();
    printf("按任意键返回上层...");
    getchar();
}
SeqStack *init_SeqStack()//置空栈
{
    SeqStack *s;
    s=(SeqStack *)malloc(sizeof(SeqStack));
    s->top=0;
    return s;
}



void push(SeqStack *s,int x,int *visit)//入栈
{
    s->top++;
    s->stack[s->top]=x;
    visit[x]=1;
}



void pop(SeqStack *s,int *visit)
{
    visit[s->stack[s->top]]=0;
    s->top--;
}



int Adjvex(adjmartrix *b,int v,int w)
{
    int i;
    for(i=1+w;i<=b->portnum;i++)
    {
        if(b->routes[v][i]!=infinity)
        {
            w=i;
            return i;
        }
    }
    return -1;
}



void DFS(adjmartrix *b,int start,int end,int *visit,SeqStack *s,adjlist *a)//深度遍历搜索
{
    int w=0,i;
    push(s,start,visit);//start入栈
    if(start==end)
    {   printf("%s",a->vertex[s->stack[1]].airportname);
        for(i=2;i<=s->top;i++)//输出栈内的元
            printf("--->%s",a->vertex[s->stack[i]].airportname);
        printf("\n");
        pop(s,visit);//退栈
        return;
    }
    w=Adjvex(b,start,0);
    while(w!=-1)
    {
        
        if(!visit[w])
        {
            DFS(b,w,end,visit,s,a);
            
        }
        w=Adjvex(b,start,w);
    }
    pop(s,visit);
}



void allroute(adjlist *a)//两机场之间所有航线
{
    int i,end = 0,start = 0,visit[maxsize],flag=1;
    char t[20],d[20];
    SeqStack *s=init_SeqStack();
    adjmartrix b=Exchange(a);//邻接表转化成矩阵
    for(i=1;i<=a->portnum;i++)
        visit[i]=0;
    printf("请输入起点名称和终点名称(空格隔开):\n");
    scanf("%s %s",t,d);
    for(i=1;i<=a->portnum;i++)
    {
        if(strcmp(t,a->vertex[i].airportname)==0)
        {
            start=i;
            flag=1;
            break;
        }
        flag=0;
    }
    if(flag==0)
    {
        printf("此起点不存在!");
        getchar();
        printf("按任意键返回上层...");
        getchar();
        return;
    }
    for(i=1;i<=a->portnum;i++)
    {
        if(strcmp(d,a->vertex[i].airportname)==0)
        {
            end=i;
            flag=1;
            break;
        }
        flag=0;
    }
    if(flag==0)
    {
        printf("此终点不存在!");
        getchar();
        printf("按任意键返回上层...");
        getchar();
        return;
    }
    printf("%s到%s的所有航线为:\n",a->vertex[start].airportname,a->vertex[end].airportname);
    DFS(&b,start,end,visit,s,a);
    getchar();
    printf("按任意键返回上层...");
    getchar();
}



void prim(adjmartrix *b,int start)//prim算法求最佳换乘航线
{
    struct
    {
        int adjvex;
        int lowcost;
    }closedge[maxsize];
    int i,e,s,m = 0,min;
    closedge[start].lowcost=0;
    for(i=1;i<=b->portnum;i++)
        if(i!=start)
        {
            closedge[i].adjvex=start;
            closedge[i].lowcost=b->routes[start][i];
        }
    for(e=1;e<=b->portnum-1;e++)
    {
        min=infinity;
        for(s=1;s<=b->portnum;s++)
        {
            if(closedge[s].lowcost!=0&&closedge[s].lowcost<min)
            {
                m=s;
                min=closedge[s].lowcost;
            }
            
        }
        printf("%s--->%s   航线航行时长为%d\n",b->airpotname[closedge[m].adjvex],b->airpotname[m],closedge[m].lowcost);
        closedge[m].lowcost=0;
        for(i=1;i<=b->portnum;i++)
            if(i!=m&&b->routes[m][i]<closedge[i].lowcost)
            {
                closedge[i].lowcost=b->routes[m][i];
                closedge[i].adjvex=m;
            }
    }
}



void bestroute(adjlist *a)
{
    int i,start = 0,flag=1;
    char t[20];
    adjmartrix b=Exchange(a);//邻接表转化成矩阵
    printf("请输入起点名称:\n");
    scanf("%s",t);
    for(i=1;i<=a->portnum;i++)
    {
        if(strcmp(t,a->vertex[i].airportname)==0)
        {
            start=i;
            flag=1;
            break;
        }
        flag=0;
    }
    if(flag==0)
    {
        printf("此机场不存在!");
        getchar();
        printf("按任意键返回上层...");
        getchar();
        return;
    }
    prim(&b,start);
    getchar();
    printf("按任意键返回上层...");
    getchar();
}
int key()//管理密码
{
    char key[20],m[20];
    FILE *s;
    s=fopen("key.txt","r");
    if(s==NULL)
    {   s=fopen("key.txt","wt");
        printf("请创建管理密码:\n");
        scanf("%s",key);
        fprintf(s,"%s",key);
        fclose(s);
        printf("恭喜您创建成功!\n");
        getchar();
        printf("按任意键继续...");
        getchar();
        return 1;
    }
    else
    {  fscanf(s,"%s",m);
        fclose(s);
        printf("请输入管理密码:\n");
        scanf("%s",key);
        if(strcmp(m,key)==0)
        {
            printf("密码正确!\n");
            getchar();
            printf("按任意键继续...");
            getchar();
            return 1;
        }
        else
        {
            printf("密码错误!\n");
            getchar();
            printf("按任意键继续...");
            getchar();
            return 0;
        }
    }
    
}



void System(adjlist *a)
{
    int s,flag=1;
    system("cls");
    flag=key();
    if(flag==1)
        do
        {
            system("cls");
            printf("******************************************\n");
            printf("*            1.修改机场名称              *\n");
            printf("*            2.修改机场安全系数          *\n");
            printf("*            3.修改机场叙述              *\n");
            printf("*            4.增加机场                  *\n");
            printf("*            5.删除机场                  *\n");
            printf("*            6.修改航线名称              *\n");
            printf("*            7.修改航行时长              *\n");
            printf("*            8.增加航线                  *\n");
            printf("*            9.删除航线                  *\n");
            printf("*            10.重新初始化(请慎重!)      *\n");
            printf("*            0.返回                      *\n");
            printf("******************************************\n");
            printf("请选择:");
            scanf("%d",&s);
            system("cls");
            switch(s)
            {
                case 1:modify(s,a);break;/*修改机场名称*/
                case 2:modify(s,a);break;/*修改机场安全系数*/
                case 3:modify(s,a);break;/*修改机场叙述*/
                case 4:add(s,a);break;/*增加机场*/
                case 5:del(s,a);break;/*删除机场*/
                case 6:modifyroute(s,a);break;/*修改航线名称*/
                case 7:modifyroute(s,a);break;/*修改航行时长*/
                case 8:add(s,a);break;/*增加航线*/
                case 9:del(s,a);break;/*删除航线*/
                case 10:creategraph(a);break;/*重新初始化(慎重)*/
            }
        }while(s!=0);
}



int main()
{
    int q;
    adjlist a;
    FILE *sfp,*rfp;
    sfp=fopen("air.txt","r");
    rfp=fopen("route.txt","r");
    if(sfp==NULL)
        creategraph(&a);
    else
        readfile(&a,sfp,rfp);
    do
    {
        system("cls");
        printf("\n\n\n\n\n");
        printf("**********************************************\n");
        printf("*           欢迎使用航班换乘服务系统         *\n");
        printf("*                                            *\n");
        printf("*           1.显示所有机场和航线             *\n");
        printf("*                                            *\n");
        printf("*           2.两机场之间所有航线             *\n");
        printf("*                                            *\n");
        printf("*           3.最佳换乘航线查询               *\n");
        printf("*                                            *\n");
        printf("*           4.最佳航程查询                   *\n");
        printf("*                                            *\n");
        printf("*           5.系统管理                       *\n");
        printf("*                                            *\n");
        printf("*           0.退出系统                       *\n");
        printf("*                                            *\n");
        printf("**********************************************\n");
        printf("                请选择:");
        scanf("%d",&q);
        system("cls");
        switch(q)
        {
            case 1: showall(&a);break;
            case 2: allroute(&a);break;
            case 3: bestroute(&a);break;
            case 4: bestvoyage(&a);break;
            case 5: System(&a);break;
        }
    }while(q!=0);
}


