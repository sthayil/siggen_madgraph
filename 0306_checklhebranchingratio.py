#usage: python 1802_lhetoroot.py inputlhefilename.lhe
#0307 mod: also check branching ratio and split up jets by category

from ROOT import *
from array import array
import sys

class particle:
    def __init__(self,pdgid,status,mother1,mother2,mass,ctau,spin,p4):
        self.pdgid = pdgid
        self.status = status
        self.mother1 = mother1
        self.mother2 = mother2
        self.mass = mass
        self.ctau = ctau
        self.spin = spin    
        self.p4 = p4

#events is an array of arrays. each subarray are the eventlines for one event; line[0] has event info, line 1 onwards are particles
events = []
event = ""
eventlines=[]
in_event = False
fname_in = sys.argv[1]
#fname_in = "unweighted_events.lhe"
with open(fname_in, "r") as fhin:
    iline = 0
    for line in fhin:

        if in_event and line.startswith("<"):
            in_event = False
            events.append(eventlines)
            eventlines = []

        if in_event:
            eventlines.append(line)

        if line.startswith("<event>"):
            in_event = True

#    if event:
#        events.append(event)

#particles is an array of previously defined class ' particles'. eventparticles is an array with all particles for each event.
eventparticles=[]
print "Num evts: ", len(events)
for event in events:
    particles=[]
    evtthings = event[0].split()
    numparts = evtthings[0]
    for i in range(1,int(numparts)+1):
        particlethings = event[i].split()
        evtparticle = particle( int(particlethings[0]), int(particlethings[1]), int(particlethings[2]), int(particlethings[3]), float(particlethings[10]), float(particlethings[11]), float(particlethings[12]), TLorentzVector(float(particlethings[6]), float(particlethings[7]), float(particlethings[8]), float(particlethings[9])) )
        particles.append(evtparticle)
    eventparticles.append(particles)

###MAKE PLOTS
outputfile = (sys.argv[1])[:-4]+'_basicanalysis.root'
out_file = TFile(outputfile, 'recreate')

leptons = [11, 13, 15]
quarks = [1,2,3,4,5,6,21]
visible = [1,2,3,4,5,6,11,13,15,21,22]

hist_numleptons  = TH1F('hist_numleptons','numleptons',10,0,10)
hist_numtau      = TH1F('hist_numtau','numtau',10,0,10)
hist_numjets     = TH1F('hist_numjets','numjets',20,0,20)
hist_leptonpt       = TH1F('hist_leptonpt','leptonpt',30,0,300)
hist_jetpt          = TH1F('hist_jetpt','jetpt',100,0,1000)
hist_eventht        = TH1F('hist_eventht','eventht',300,0,3000)
hist_leptoniso   = TH1F('hist_leptoniso','leptoniso',150,0,15)

stableparts=[]
count=0

lepev=0
elev=0
muev=0
tauev=0

ht1050=0
ht450lep20=0
ht1050lep=0
ht450lep=0
ht450=0

for particles in eventparticles: #particles is always an array of 'particles'; particles[i].XXXX accesses members. for each event:
    numlep=0
    numtau=0
    numq=0
    visE=0

    haslep=0
    hasel=0
    hasmu=0
    hastau=0
    haslep20=0
    
    for i in range(len(particles)):
        if particles[i].status == 1: #if stable
            stableparts.append(particles[i].pdgid)
            #pdgid,status,mother1,mother2,p4,mass,ctau,spin

            if abs(particles[i].pdgid) in visible:
                if abs(particles[i].pdgid) in leptons: 
                    numlep+=1
                    hist_leptonpt.Fill(particles[i].p4.Pt())
                    haslep=1

                    if particles[i].p4.Pt()>20:
                        haslep20=1
                        
                    conept=0
                    isolation=0
                    for j in range(len(particles)):
                        if particles[j].status == 1:
                            deltar = particles[i].p4.DeltaR(particles[j].p4)
                            if deltar < 0.3 and deltar > 0:
                                conept+=particles[j].p4.Pt()
                    isolation = conept / particles[i].p4.Pt()
                    hist_leptoniso.Fill(isolation)

                if abs(particles[i].pdgid) == 15 : 
                    numtau+=1
                    hastau=1
                    
                if abs(particles[i].pdgid) == 11 : hasel=1
                if abs(particles[i].pdgid) == 13 : hasmu=1
                
                if abs(particles[i].pdgid) in quarks: 
                    numq+=1
                    hist_jetpt.Fill(particles[i].p4.Pt())
                    visE+=(particles[i].p4.Pt())

    hist_numleptons.Fill(numlep)
    hist_numtau.Fill(numtau)
    hist_numjets.Fill(numq)
    hist_eventht.Fill(visE)

    if haslep==1: lepev+=1
    if hasel==1: elev+=1
    if hasmu==1: muev+=1
    if hastau==1: tauev+=1
    
    if (visE>1050): ht1050+=1
    if (visE>450 and haslep20==1): ht450lep20+=1
    if (visE>1050 and haslep==1): ht1050lep+=1
    if (visE>450 and haslep==1): ht450lep+=1
    if (visE>450): ht450+=1

    stableparts=list(set(stableparts))    
    count+=1

stableparts.sort()
print "\nStable particles: ", stableparts
print "\nNum events: ", count
print "Num events with leptons: ", lepev
print "Num events with el: ", elev
print "Num events with mu: ", muev
print "Num events with tau: ", tauev
print "\nNum events with HT>1050: ", ht1050
print "Num events with HT>1050, lep: ", ht1050lep
print "Num events with HT>450, lep pT>20:", ht450lep20
print "Num events with HT>1050, lep: ", ht450lep
print "\nNum events with HT>1050: ", ht450

out_file.cd()
out_file.Write()
out_file.Close()
