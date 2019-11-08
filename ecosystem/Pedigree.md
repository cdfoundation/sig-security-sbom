# Pedigree


### Chain Pedigree

The chain is as strong as its links.  If a single link is compromised, then the entire chain is faulty and should be considered compromised.   Consumers should have a way of knowing what the strength of the chain they are consuming is.  For this reason, a proposal to categorize chain credibility should be in place for informing consumers and policy management. 
For a chain to be a certain type, all links need to be the same.  Status of the chain will not change until all the links are the same standard.   For example, if a chain has all functionaries of type gold except for one functionary of type red, the chain will move down to the lowest type of the link, in this case red.  Having such standards will help us maintain credibility across the board and maintain policy. 


### Functionary Pedigree


#### Developer
* Red Developer (validated only via GCR).
* Green Developer (validated via GCR and uses YubiKey).
* Gold Developer (validated via GCR, uses YubiKey and builds using prebuilt Sec Supply chain containers / VM, Reproducible build).



#### CI/CD
* Red CI/CD: (validated only via GCR).
* Green Developer (validated via GCR, uses HSM).
* Gold Developer (validated via GCR, uses HSM, for elastic environments node data is stored, build environment meets CIS / FIPS standards, Reproducible build).



#### RMS/Pkg Repo
* Red Distributor (validated only via GCR).
* Green Distributor (validated via GCR and uses HSM).
* Gold Distributor (validated via GCR, uses HSM, host environment meets CIS / FIPS standards, built on top of Sec Supply chain containers, Reproducible build).

