func (s *StreamServer) processCmdBookmark(clientId string) error {
    // Read bookmark length parameter from the network
    conn := s.clients[clientId].conn
    length, err := readFullUint32(conn)
    if err != nil {
        return err
    }
    // Read bookmark parameter
    bookmark, err := readFullBytes(length, conn)
    if err != nil {
        return err
    }
    //...
}
//Read the number of bytes for a given connection
func readFullBytes(length uint32, conn net.Conn) ([]byte, error) {
    var err error = nil
    // Read number length of bytes
    buffer := make([]byte, length)
    if length > 0 {
        _, err := io.ReadFull(conn, buffer)


    //...

}
