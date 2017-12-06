wp=0.2*pi;
ws=0.35*pi;
Rp=1;As=15;
ripple=10^(-Rp/20);
Attn=10^(-As/20);

Fs=2000;T=1/Fs;Omgp=wp*Fs;Omgs=ws*Fs;

[n,Omgc]=buttord(Omgp,Omgs,Rp,As,'s')
[z0,p0,k0]=buttap(n);
bal=k0*real(poly(z0));
aal=real(poly(p0));
[ba,aa]=lp2lp(bal,aal,Omgc);

[bd,ad]=impinvar(ba,aa,Fs)
[H,w]=freqz(bd,ad);
dbH=20*log10((abs(H)+eps)/max(abs(H)));
subplot(2,2,1);plot(w/pi,abs(H));
ylabel('|H|');title('幅度响应');axis([0,1,0,1.1]);
set(gca,'XTickMode','manual','XTick',[0,0.25,0.4,1]);
set(gca,'YTickMode','manual','YTick',[0,Attn,ripple,1]);grid
subplot(2,2,2);plot(w/pi,angle(H)/pi);
ylabel('\phi');title('相位响应');axis([0,1,-1,1]);
set(gca,'XTickMode','manual','XTick',[0,0.25,0.4,1]);
set(gca,'YTickMode','manual','YTick',[-1,0,1]);grid
subplot(2,2,3);plot(w/pi,dbH);title('幅度响应(dB)');
ylabel('dB');xlabel('频率(\pi)');axis([0,1,-40,5]);
set(gca,'XTickMode','manual','XTick',[0,0.25,0.4,1]);
set(gca,'YTickMode','manual','YTick',[-50,-15,-1,0]);grid
subplot(2,2,4);zplane(bd,ad);axis([-1.1,1.1,-1.1,1.1]);title('零极点图');