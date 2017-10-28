/**
 * 
 */
package org.topicquests.ks.api;

/**
 * @author park
 *
 */
public interface IVersionable {
	public static final String
		VERSION_PROPERTY = ITQCoreOntology.VERSION;
	
	/**
	 * Use a  <code>_version_</code> field
	 * @param version
	 */
	void setVersion(String version);
	
	/**
	 * Return the SOLR4 version as a String
	 * @return
	 */
	String getVersion();

}
