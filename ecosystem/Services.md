# Services


## Global SBOM Registry (GSR)


  The Global SBOM Registry (GSR) will play a key role in the overall SBOM infrastructure. Its role is to serve as a central location for storage and retrieval of SBOM data.  Aside from storage, GSR will help in proactive/reactive security practices and policies.   Without GSR in the SBOM infrastructure, consumers will need to search across multiple chains locally and in RMS’s known/unknown to update policies.

  To mitigate the risk of having a single point of failure which is also serving as a single point of truth.  GSR will be distributed across a globally distributed network managed by consortium of trusted participants.   Entries made into GSR will require a minimum of three participant approval and this can be detailed out further in the future of what standards the participants, environment, approval process needs.   GSR will be leveraged in categorizing chains (see pedigree section), invalidating functionaries or entire chains, refer to the invalidation document for details.

  
### List of use cases:

* Central authority on SBOMs for reads/writes.
* Global invalidation of functionaries & chains.
* Proactive security, leveraging ML for anomaly detection across multiple ingestion points.
* Reactive security, searching for a compromised functionary at global scale.
* Policy management, functionaries/consumers can set policies to consume a chain that matches a particular pedigree (discussed below in pedigree).


## Global Cert Authority (GCR)

To be added later.


