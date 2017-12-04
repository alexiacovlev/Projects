namespace DMS.WebDav.Module
{
    /// <summary>
    /// Type of the item stored in database.
    /// </summary>
    public enum ItemType
    {
        /// <summary>
        /// Undefined item type.
        /// </summary>
        Unknown = 0,

        /// <summary>
        /// The item is file.
        /// </summary>
        File = 2,

        /// <summary>
        /// The item is folder.
        /// </summary>
        Folder = 3,
        /// <summary>
        /// The item is version.
        /// </summary>
        Version = 4,

        /// <summary>
        /// The item is version history resource.
        /// </summary>
        VersionHistory = 5
    }
}
