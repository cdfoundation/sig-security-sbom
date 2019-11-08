#FAQ

##The purpose of this document is to catalog (and answer) questions that arise during ramp up to the topic of Software Supply Chain Security AND the underpinning SBOM (software bill of materials) effort. 
 
####Q: How are SBOM entries attributed? 

A: 
 
####Q: Are hashes to SBOM entries signed? 

A: 
 
####Q:  Should we create different levels of Authority when creating SBOMS  or do all parts have equal weight ?  For example an RMS with HSM who is CIS / fips compliant or a developer who is verified via multiple means, uses something like a yubikey or is part of an org vs a developer or RMS with no security standards in place? 

A:  Initial brainstorming started in Pedigree page
 
####Q: How are SBOM entries invalidated?  
The white paper reads, “A key idea in driving that minimalization is to aim at having the data in the SBOM static and fixed. Any information that will change and evolve over time should be separately managed so it can be correlated and linked to the SBOM, but it should not be included in the SBOM.” This seems to indicate that qualitative assessments that might change over time should be stored separately. But what of entries that authors (machine or human) might wish to invalidate? 

A:  

####Q: If a parent SBOM is invalidated, what should this say about all its children, should they be considered invalid as valid ?

A:
 
####Q: As an SBOM moves across the chain, should it be encrypted? 

A: 
 
####Q: If a vulnerability is found, what services need to be in place to handle the invalidation of the comprised node in the chain ? 

A: 
 
####Q: For elastic environments that spin up nodes or containers for a build, do we create a unique signatures based on the parent ? 

A: 
 
####Q: For larger RMS’s or distro/package managers are there any standards they should adhere to CIS or FIPS, Secure/approved docker containers or VM’s in their build process, Vulnerability scanning etc? 

A:  
 
