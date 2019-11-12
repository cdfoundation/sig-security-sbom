# FAQ

## The purpose of this document is to catalog (and answer) questions that arise during ramp up to the topic of Software Supply Chain Security AND the underpinning SBOM (software bill of materials) effort. 

#### Q: Do repositories sign off on metadata? if they are not changing the artifact in any way do they really need to sign it?  This goes back to, if a link in a chain is not changing any bits, then does it add to the SBOM or is it just serving as a host for the artifact ?
 
A:

#### Q: What keys are we using to sign the SBOM ?

A:

#### Q: What are reference limits for an artifact and its dependencies, how far do you go back ?

A:

#### Q: If a Compromise is found in any part of the chain, do you patch the artifact and update the SBOM, or do you rebuild from the point of compromise ?

A: 

#### Q: Will you store hashes inside SBOM, and how will you handle SBOM builds with thousands of files ?

A: In this case we will use the hash of the index file that contains all the hashes of the files in the build (merkel tree).


#### Q: Aside from capturing dependeny information for an artifact, are we also capturing versions of those dependencies ?

A:


#### Q: How are SBOM entries attributed? 

A: 
 
#### Q: Are hashes to SBOM entries signed? 

A: 
 
#### Q:  Should we create different levels of Authority when creating SBOMS  or do all parts have equal weight ?  For example an RMS with HSM who is CIS / fips compliant or a developer who is verified via multiple means, uses something like a yubikey or is part of an org vs a developer or RMS with no security standards in place? 

A:  Initial brainstorming started in Pedigree page
 
#### Q: How are SBOM entries invalidated?  
The white paper reads, “A key idea in driving that minimalization is to aim at having the data in the SBOM static and fixed. Any information that will change and evolve over time should be separately managed so it can be correlated and linked to the SBOM, but it should not be included in the SBOM.” This seems to indicate that qualitative assessments that might change over time should be stored separately. But what of entries that authors (machine or human) might wish to invalidate? 

A:  

#### Q: If a parent SBOM is invalidated, what should this say about all its children, should they be considered invalid as valid ?

A:
 
#### Q: As an SBOM moves across the chain, should it be encrypted? 

A: 
 
#### Q: If a vulnerability is found, what services need to be in place to handle the invalidation of the comprised node in the chain ? 

A: 
 
#### Q: For elastic environments that spin up nodes or containers for a build, do we create a unique signatures based on the parent ? 

A: 
 
#### Q: For larger RMS’s or distro/package managers are there any standards they should adhere to CIS or FIPS, Secure/approved docker containers or VM’s in their build process, Vulnerability scanning etc? 

A:  
 
